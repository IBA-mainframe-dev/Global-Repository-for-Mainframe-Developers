
# Jenkins MF pipeline code example

## Git repos
For this Jenkins pipeline example, 3 Git repositories were created (in our case - in GitLab):
1) **Program** - it contains all the code sources which needed to be built and installed in the SMP/e.
2) **Script** - a repository for various shell scripts, which needed during pipeline execution. For example, shell scripts for sending data sets and running them (The required shell scripts are also located in our GRMD repository as separate modules).
3) **Test** - a repository that stores auto-tests, which should be launched, while the pipeline is running.

Also, the repositories use two branches:
1) **develop** - your development branch where new functionality is being developed
2) **zigi-master** - master branch to which tested and ready sources will be added

## Jenkins plugins
Before starting work, for the pipeline execution, you will need pre-installed and pre-configured Jenkins plugins, such as:
1. Version control system you are using - GitHub, GitLab or Bitbucket
2. [Jira](https://plugins.jenkins.io/jira/)
3. [JIRA Pipeline Steps](https://plugins.jenkins.io/jira-steps/)
4. [JiraTestResultReporter](https://plugins.jenkins.io/JiraTestResultReporter/)
5. [Sonar Quality Gates Plugin (if you have a trial or full version)](https://plugins.jenkins.io/sonar-quality-gates/)
6. [SonarQube Scanner (if you have a trial or full version)](https://plugins.jenkins.io/sonar/)
7. [TestLink Plugin](https://plugins.jenkins.io/testlink/)
8. [Slack Notification](https://plugins.jenkins.io/slack/)

## Build Triggers
Pipeline is triggered by a webhook trigger with the git action you need (push/pull or merge requests, etc.). This trigger should be configured in **Build Triggers** pipeline section, using pre-installed and pre-configured Git plugins (for example GitHub, GitLab, Bitbucket plugins).

In our example, we made a push request trigger to a specific branch with the following commit example.

```JIRA-111 New feature developed``` - Commit message must contain Jira ticket ID which is used to document pipeline execution progress. See also example of commit to git repository from z/OS in the “Git for z/OS” section.

## Pipeline code example
You can find the entire pipeline code in a separate file or here in the article. Below we provide a description of each stage and its goals.

*NOTE*: Make sure you replace all the values in "<>" braces with your own, as examples of sources, tests and other parameters are different for everyone.
1. [**Jenkins Declarative Pipeline code in a separate groove file**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Jenkins%20MF%20pipeline%20code%20example/mf_pipeline_example.groovy)

 
<details>
  <summary>2. Jenkins Declarative Pipeline code:</summary>
  
```
def emaildev = '<your email>' 
def emailtest = '<tester email>'
def jiraSite = '<Jira Site from Jira plugin configs>'
def HLQ = '<data sets HLQ, for example USER01.TESTPROG>'
def JCLLIB = '<dataset with all the necessary JCLs for building and working with SMP/E: USER01.TESTPROG.JCL>'
def jiraID = ''
def gitToken = '<your git user token>'
def envErrLabel = 'bug'
def gitRepId = '<git repository id (for GitLab)>'
def json
def BRANCH = '<your development branch where new functionality is being developed, for our example branch name: develop>'
def STAGE

// Jira transitions id's are always different for each Jira server, check yours and substitute here
def transitionToDo = [transition: [id: '11']] 
def transitionInProgress = [transition: [id: '21']]
def transitionDone = [transition: [id: '31']]


pipeline {
   agent any
     stages {
       stage('Check code') {
             steps {
                 script { STAGE=env.STAGE_NAME }
                 git branch: 'develop', credentialsId: '<Jenkins credential with access to the git repository with the necessary rights>', 
                 url: '<your git repository with program sources>'
                
                 script { emaildev = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%ae\'')   }
                 echo "${emaildev}" 
                
                 jiraAddComment idOrKey: "${jiraID}", comment: 'Jenkins Pipeline is started', site: "${jiraSite}"
                
                 build 'Check code from Git'
                   }
             post {
                 success {
                     //sh 'echo successful'
                     jiraAddComment idOrKey: "${jiraID}", comment: 'Code check done', site: "${jiraSite}"
                 }
                 failure {
                     //sh 'echo failed'
                     jiraAddComment idOrKey: "${jiraID}", comment: 'Code check was not completed', site: "${jiraSite}"
                    
                     //mail to developer
                     emailext (
                     attachLog: true,
                     subject:"Code check failed",
                     body:"Code check was not completed. See attached pipeline log.",
                     to: "${emaildev}"
                     )
                 }
             }
         }
        
      stage('Build') {
            steps {
                script { STAGE=env.STAGE_NAME }
                slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                
                //Get sources and scripts from GIT
                dir('master') {
                    git branch: '<master branch to which tested and ready sources will be added. In our case: zigi-master>', credentialsId: '<Jenkins credential with access to the git repository with the necessary rights>', 
                    url: '<your git repository with program sources>'
                }
                dir('script') {
                    git branch: 'master', credentialsId: '<Jenkins credential with access to the git repository with the necessary rights>',
                    url: '<your git repository with scripts sources>'
                }
                
                //Copy scripts to the curent directory
                sh '''
                   cp $PWD/script/zOS/sendChangedSrc.sh sendChangedSrc.sh
                   cp $PWD/script/zOS/runZosJcl.sh runZosJcl.sh
                   cp $PWD/script/config/setBranch.sh setBranch.sh
                '''
                
                //Set branch in vardefs file
                sh  " ./setBranch.sh  ${env.gitlabSourceBranch}"
               
               //Get branch name from vardefs file
                 script { BRANCH = sh(returnStdout: true, 
                script: '''
                VAR_PATH="/$PWD/script/config/vardefs"
                . "$VAR_PATH"
                echo $developBranch
                ''').trim()  }
                
                git branch: "${BRANCH}", credentialsId: '<Jenkins credential with access to the git repository with the necessary rights>', 
                url: '<your git repository with program sources>'
                
                script { emaildev = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%ae\'')   }
                echo "${emaildev}"  
                script { jiraID = sh(returnStdout: true, script: 'git log -1 --pretty=%B | grep -o "DVASS-[0-9][0-9]*"').trim()  }
                echo "${jiraID}"
         
                jiraTransitionIssue idOrKey: "${jiraID}", input: transitionInProgress, site: "${jiraSite}"
                jiraAddComment idOrKey: "${jiraID}", comment: 'Jenkins Pipeline is started', site: "${jiraSite}"
                
                //Send changed sources on z/OS
                sh  " ./sendChangedSrc.sh  ${HLQ}"
                
                //Run build JCLs - create object and load modules for our code sources (change to yours build JCL's)
                sh  " ./runZosJcl.sh  \'${JCLLIB}(ALLLIBS)\' alloclibs.log"
                sh  " ./runZosJcl.sh  \'${JCLLIB}(ASSEMBLD)\' assem_bld.log"
                sh  " ./runZosJcl.sh  \'${JCLLIB}(COBOLBLD)\' cobol_bld.log"
                sh  " ./runZosJcl.sh  \'${JCLLIB}(PLIBLD)\' pli_bld.log"
            }
            post{
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Build stage completed successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Build stage failed', site: "${jiraSite}"
                    
                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    //mail to developer
                    emailext (
                    attachLog: true,
                    subject:"Build failed",
                    body:"Build stage failed. See attached pipeline log.",
                    to: "${emaildev}"
                    )
                }
            }
        }
        
      // Build docker images for running tests in docker containers. Docker images for test are created in Jenkins job 'Testing - Docker build'.
      // Tests are executed by the ‘Unit/Functional/Integration tests’ Jenkins jobs.     
      stage('Docker build') {
            steps {
                script { STAGE=env.STAGE_NAME }
                build job: 'Testing - Build docker image', parameters: [string(name: 'Branch_name', value: BRANCH)]
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Docker build stage completed successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Docker build stage failed', site: "${jiraSite}"
                    
                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    //mail to developer
                    emailext (
                    attachLog: true,
                    subject:"Docker build failed",
                    body:"Docker build stage failed. See attached pipeline log.",
                    to: "${emaildev}"
                    )
                }
            }
        } 
        
      stage('Unit tests') {
            steps {
                script { STAGE=env.STAGE_NAME }
                // build 'Testing - Unit-tests'
                build job: 'Testing - Unit-tests', parameters: [string(name: 'Jira_issue', value: jiraID)]
            }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Unit tests completed successfully', site: "${jiraSite}"
                }
                unstable {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Unit tests failed', site: "${jiraSite}"
					
		//Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
			
		//mail to developer
		    emailext (
                    attachLog: true,
                    subject:"Unit tests failed",
                    body:"Unit tests failed. See attached pipeline log.",
                    to: "${emaildev}"
                    )
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Unit tests failed', site: "${jiraSite}"
					
		//Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
		//mail to developer
		    emailext (
                    attachLog: true,
                    subject:"Unit tests failed",
                    body:"Unit tests failed. See attached pipeline log.",
                    to: "${emaildev}"
                    )
                }
                
            }
        }
      
      stage('Prepare input data for PTF') {
            steps {
                script { STAGE=env.STAGE_NAME }
                sh  " ./runZosJcl.sh  \'${JCLLIB}(CRTSTAGE)\' CRTSTAGE.log"
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Input data for PTF is prepared successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Preparing input data for PTF failed', site: "${jiraSite}"
					
		//Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
					
		//mail to packaging team
		    emailext (
                    attachLog: true,
                    subject:"Preparing input data for PTF failed",
                    body:"Preparing input data for PTF failed. See attached pipeline log.",
                    to: '$DEFAULT_RECIPIENTS'
                    )
                }
            }
        }
       
      stage('Build PTF') {
            steps {
                script { STAGE=env.STAGE_NAME }
                sh  " ./runZosJcl.sh  \'${JCLLIB}(PTFBLD)\' PTFBLD.log"
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Build PTF completed successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Build PTF failed', site: "${jiraSite}"
					
		//Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
					
		//mail to packaging team
		    emailext (
                    attachLog: true,
                    subject:"Build PTF failed",
                    body:"Build PTF failed. See attached pipeline log.",
                    to: '$DEFAULT_RECIPIENTS'
                    )
                }
            }
        }
        
      stage('Receive PTF') {
            steps {
                script { STAGE=env.STAGE_NAME }
                sh  " ./runZosJcl.sh  \'${JCLLIB}(RECVPTF)\' RECVPTF.log"
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Receive PTF completed successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Receive PTF failed', site: "${jiraSite}"
					
		//Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
		//mail to packaging team
		    emailext (
                    attachLog: true,
                    subject:"Receive PTF failed",
                    body:"Receive PTF failed. See attached pipeline log.",
                    to: '$DEFAULT_RECIPIENTS'
                    )
                }
            }
        }
      
      stage('Apply PTF') {
            steps {
                script { STAGE=env.STAGE_NAME }
                sh  " ./runZosJcl.sh  \'${JCLLIB}(APPLYPTF)\' APPLYPTF.log"
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Apply PTF completed successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Apply PTF failed', site: "${jiraSite}"
                    
                    //Reject PTF to clean up the global zone and SMP/E datasets
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(REJCTPTF)\' REJCTPTF.log"
                    
                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    script {
                        json = "{\"title\": \"Problem while ${STAGE}\", \"description\": \"step ${STAGE} failed, please check environment\", \"labels\": \"${envErrLabel}\"}"
                        openBug = sh(returnStdout: true, script: "curl -X POST --header \"PRIVATE-TOKEN: ${gitToken}\" --header \"Content-Type: application/json\" -d '${json}' \"https://<your git base url>/api/v4/projects/${gitRepId}/issues\"")
                    }
                    
                    //mail to packaging team
                    emailext (
                    attachLog: true,
                    subject:"Apply PTF failed",
                    body:"Apply PTF failed. See attached pipeline log.",
                    to: '$DEFAULT_RECIPIENTS'
                    )
                }
            }
        } 
      
      stage('Functional tests') {
            steps {
                script { STAGE=env.STAGE_NAME }
                // build 'Testing - Functional-tests'
                build job: 'Testing - Functional-tests', parameters: [string(name: 'Jira_issue', value: jiraID)]
            }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Functional tests completed successfully', site: "${jiraSite}"
                }
                unstable {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Functional tests failed', site: "${jiraSite}"

                    //Restore and reject PTF to clean up the target, global zones and SMP/E datasets 
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(RESTRPTF)\' RESTRPTF.log"
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(REJCTPTF)\' REJCTPTF.log"
                    
                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    //mail to tester
		    emailext (
                    attachLog: true,
                    subject:"Functional tests failed",
                    body:"Functional tests failed. See attached pipeline log.",
                    to: "${emailtest}"
                    )
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Functional tests failed', site: "${jiraSite}"

                    //Restore and reject PTF to clean up the target, global zones and SMP/E datasets 
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(RESTRPTF)\' RESTRPTF.log"
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(REJCTPTF)\' REJCTPTF.log"
                    
                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    //mail to tester
		    emailext (
                    attachLog: true,
                    subject:"Functional tests failed",
                    body:"Functional tests failed. See attached pipeline log.",
                    to: "${emailtest}"
                    )
                }
            }
        }
        
      stage('Apply on other env') {
            steps {
                script { STAGE=env.STAGE_NAME }
                sh  " ./runZosJcl.sh  \'${JCLLIB}(SENDLIBS)\' SENDLIBS.log"
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Apply on other env completed successfully', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Apply on other env failed', site: "${jiraSite}"
                    
                    //Restore and reject PTF to clean up the target, global zones and SMP/E datasets 
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(RESTRPTF)\' RESTRPTF.log"
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(REJCTPTF)\' REJCTPTF.log"

                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    script {
                        json = "{\"title\": \"Problem while ${STAGE}\", \"description\": \"step ${STAGE} failed, please check environment\", \"labels\": \"${envErrLabel}\"}"
                        openBug = sh(returnStdout: true, script: "curl -X POST --header \"PRIVATE-TOKEN: ${gitToken}\" --header \"Content-Type: application/json\" -d '${json}' \"https://<your git base url>/api/v4/projects/${gitRepId}/issues\"")
                    }
                    
                    //mail to env team
                    emailext (
                    attachLog: true,
                    subject:"Apply on other env failed",
                    body:"Apply on other env failed. See attached pipeline log. Fix the error and restart pipeline from this stage.",
                    to: '$DEFAULT_RECIPIENTS'
                    )
                }
            }
        }

      stage('Regression and other tests') {
            steps {
                  script { STAGE=env.STAGE_NAME }
                //   build 'Testing - Integrational-tests'
                  build job: 'Testing - Integrational-tests', parameters: [string(name: 'Jira_issue', value: jiraID)]
            }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Regression tests completed successfully', site: "${jiraSite}"
                } 
                unstable {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Regression tests failed', site: "${jiraSite}"
                    
                    //Restore and reject PTF to clean up the target, global zones and SMP/E datasets 
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(RESTRPTF)\' RESTRPTF.log"
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(REJCTPTF)\' REJCTPTF.log"

                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    //mail to tester
		    emailext (
                    attachLog: true,
                    subject:"Regression tests failed",
                    body:"Regression tests failed. See attached pipeline log.",
                    to: "${emailtest}"
                    )
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Regression tests failed', site: "${jiraSite}"
                    
                    //Restore and reject PTF to clean up the target, global zones and SMP/E datasets 
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(RESTRPTF)\' RESTRPTF.log"
                    sh  " ./runZosJcl.sh  \'${JCLLIB}(REJCTPTF)\' REJCTPTF.log"

                    //Restore changed modules from master branch
                    sh  " ./sendChangedSrc.sh  ${HLQ} restore "
                    
                    //mail to tester
		    emailext (
                    attachLog: true,
                    subject:"Regression tests failed",
                    body:"Regression tests failed. See attached pipeline log.",
                    to: "${emailtest}"
                    )
                }
            }
        }
     
      stage('Accept PTF') {
            steps {
                  script { STAGE=env.STAGE_NAME }
                  sh  " ./runZosJcl.sh  \'${JCLLIB}(ACCPTPTF)\' ACCPTPTF.log"
                  }
            post {
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Accept PTF completed successfully. Changes can be merged.', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Accept PTF failed', site: "${jiraSite}"
                
                    script {
                        json = "{\"title\": \"Problem while ${STAGE}\", \"description\": \"step ${STAGE} failed, please check environment\", \"labels\": \"${envErrLabel}\"}"
                        openBug = sh(returnStdout: true, script: "curl -X POST --header \"PRIVATE-TOKEN: ${gitToken}\" --header \"Content-Type: application/json\" -d '${json}' \"https://<your git base url>/api/v4/projects/${gitRepId}/issues\"")
                    }
                    
                    //mail to tester/dev responsible for smp/e env
                    emailext (
                    attachLog: true,
                    subject:"Accept PTF failed",
                    body:"Accept PTF failed. See attached pipeline log.",
                    to: '$DEFAULT_RECIPIENTS'
                    )
                }
            }
        }   
        
      stage('Reporting') {
            steps {
            script { STAGE=env.STAGE_NAME }
            jiraAddComment idOrKey: "${jiraID}", comment: 'Add list of changed modules: changesList.txt', site: "${jiraSite}"  
            jiraUploadAttachment idOrKey: "${jiraID}", site: "${jiraSite}", file: 'changesList.txt'
            
            dir('script') {
                   git branch: 'master', credentialsId: '<Jenkins credential with access to the git repository with the necessary rights>',
                   url: '<your git repository with script sources>'
                } 
            sh '''
                cp $PWD/script/Jira/attachPTFdocs/attachPTFdocs.sh  attachPTFdocs.sh 
            '''
            withCredentials([usernamePassword(credentialsId: '<Jenkins credential with access to the git repository with the necessary rights>', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh  " ./attachPTFdocs.sh ${jiraID} ${BASE_JIRA_URL} $USERNAME $PASSWORD"
                }
            }
            post{
                success {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Reporting stage completed successfully. Pipeline finished successfully.', site: "${jiraSite}"
                }
                failure {
                    jiraAddComment idOrKey: "${jiraID}", comment: 'Reporting stage failed', site: "${jiraSite}"
                    
                    //mail to developer
                    emailext (
                    attachLog: true,
                    subject:"Reporting failed",
                    body:"Reporting stage failed. See attached pipeline log.",
                    to: "${emaildev}"
                    )
                }
            }
        }
   }
    post {
           success{
                slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                jiraTransitionIssue idOrKey: "${jiraID}", input: transitionDone, site: "${jiraSite}"
            }
           unstable {
                slackSend (color: '#FF0000', message: "Failed stage name: ${STAGE}")
                jiraTransitionIssue idOrKey: "${jiraID}", input: transitionToDo, site: "${jiraSite}"
            }
            failure {
                slackSend (color: '#FF0000', message: "Failed stage name: ${STAGE}")
                jiraTransitionIssue idOrKey: "${jiraID}", input: transitionToDo, site: "${jiraSite}"
            }
    }
}
```

</details>

## Table of Contents: Description of all pipeline stages by execution order

1. [Check code](#1-check-code)
2. [Build](#2-build)
3. [Docker build](#3-docker-build)
4. [Unit tests](#4-unit-tests)
5. [Prepare input data for PTF](#5-prepare-input-data-for-ptf)
6. [Build PTF](#6-build-ptf)
7. [Receive PTF](#7-receive-ptf)
8. [Apply PTF](#8-apply-ptf)
9. [Functional tests](#9-functional-tests)
10. [Apply on other environment](#10-apply-on-other-environment)
11. [Regression and other tests](#11-regression-and-other-tests)
12. [Accept PTF](#12-accept-ptf)
13. [Reporting](#13-reporting)
14. [Declarative: Post actions](#14-declarative-post-actions)

## 1. Check code
*NOTE*: This step is optional depending on whether you have an active trial version or a full license
	
**Steps:**
* Get Jira ticket Id from commit message (for example: ```JIRA-111 New feature developed```)
* Get developer’s mail address and store it in Jenkins variable
* Clone changed branch from git
* Run SonarQube scanner to analyze code
* Check analysis results vs quality gate conditions, set pipeline status accordingly

**Failure recovery/notification actions:**
* Send e-mail to code developer

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 2. Build

**Steps:**
* Get development branch name and store it in Jenkins variable
* Clone master branch from git
* Get scripts from git
* Clone development branch from git
* Get Jira ticket Id from commit message
* Get developer’s mail address and store it in Jenkins variable
* Get list of changed modules, store it in z/OS sequential dataset <project HLQ>.DIFF 
* Save list of changed modules in changesList.txt file
* Update z/OS work datasets with changed modules (script sendChangedSrc.sh)
* Submit *BLD jobs to create object and load modules (script runZosJcl.sh)
* Send message in slack channel about starting pipeline execution
* Set status of related Jira ticket to ‘In Progress’

**Failure recovery/notification actions:**
* Restore changed modules from master branch
* Send e-mail to code developer

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 3. Docker build

**Steps:**
* Docker login
* Build docker image for <your project name>/test. It is used to run unit, functional and integration tests in docker container.
* Push docker images to dockerhub (step is currently disabled)

**Failure recovery/notification actions:**
* Restore changed modules from master branch
* Send e-mail to test developer

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 4. Unit tests

**Steps:**
* Run unit tests/suites from git repository ‘test’
* Results are stored in one of test management systems - TestLink or TestRail

**Failure recovery/notification actions:**
* Restore changed modules from master branch
* Send e-mail to test developer

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 5. Prepare input data for PTF

**Steps:**
* Submit CRTSTAGE job (script runZosJcl.sh), it executes REXX program CRTESTG that creates set of stage libraries

**Failure recovery/notification actions:**
* Restore changed modules from master branch
* Send e-mail to SMP/E packaging team

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 6. Build PTF

**Steps:**
* Submit PTFBLD job (script runZosJcl.sh), it executes REXX program PTFGEN that builds APARfix/PTF dataset from stage libraries

**Failure recovery/notification actions:**
* Restore changed modules from master branch
* Send e-mail to SMP/E packaging team

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 7. Receive PTF

**Steps:**
* Submit RECVPTF job (script runZosJcl.sh), it loads APARfix/PTF information into SMP/E global zone by RECEIVE command

**Failure recovery/notification actions:**
* Restore changed modules from master branch
* Send e-mail to SMP/E packaging team

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 8. Apply PTF

**Steps:**
* Submit APPLYPTF job (script runZosJcl.sh) that installs APARfix/PTF into the SMP/E target zone by APPLY command

**Failure recovery/notification actions:**
* Reject PTF from SMP/E global zone by REJCTPTF job 
* Restore changed modules from master branch
* Send e-mail to SMP/E packaging team
* Open environment issue in GitLab

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 9. Functional tests

**Steps:**
* Run functional tests/suites from git repository ‘test’
* Results are stored in one of test management systems – TestLink or TestRail

**Failure recovery/notification actions:**
* Remove APARfix/PTF from SMP/E global and target zones by RESTRPTF and REJCTPTF jobs
* Restore changed modules from master branch
* Open Jira bug ticket and link it to the corresponding test case in Testlink/TestRail
* Send e-mail to test developer

To get the test results from Jenkins, select the appropriate build and click on “Test Result” link, overall/failed tests statistics will appear. Failed tests section also contains link to corresponding Jira bug ticket.

<p align="center">
<img src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/images/mfarticleimages/Tests%20Results.png" width="900" alt="test results">
</p>
 
Example of execution log :
<p align="center">
<img src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/images/mfarticleimages/Tests%20execution%20logs.png" width="700" alt="execution log">
</p>

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 10. Apply on other environment

**Steps:**
* Submit SENDLIBS job (script runZosJcl.sh) that copies product SMP/E datasets to another environment

**Failure recovery/notification actions:**
* Remove APARfix/PTF from SMP/E target and global zones by RESTRPTF and REJCTPTF jobs
* Restore changed modules from master branch
* Send e-mail to default recipients list
* Open environment issue in GitLab

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 11. Regression and other tests

**Steps:**
* Run regression tests/suites from git repository ‘test’
* Results are stored in one of test management systems – TestLink or TestRail

**Failure recovery/notification actions:**
* Remove APARfix/PTF from SMP/E target and global zones by RESTRPTF and REJCTPTF jobs
* Restore changed modules from master branch
* Open Jira bug and link it to the corresponding test case in Testlink/TestRail
* Send e-mail to tests developer

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 12. Accept PTF

**Steps:**
* Submit ACCPTPTF job (script runZosJcl.sh) that installs APARfix/PTF into SMP/E distribution zone by ACCEPT command

**Failure recovery/notification actions:**
* Send e-mail to default recipients list
* Open environment issue in GitLab

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 13. Reporting

**Steps:**
* Attach list of changed modules (changesList.txt file) to related Jira ticket
* Fill the template of Transmittal_note.txt with information from Jira ticket and from list of changed modules
* Attach PTF documents (Transmittal_note.txt and RCA.xlsx) to Jira ticket (script attachPTFdocs.sh)

**Failure recovery/notification actions:**
* Send e-mail to code developer

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)

## 14. Declarative: Post actions

**Steps:**
* Send message in slack channel about successful pipeline execution
* Set status of related Jira ticket to ‘Done’

**Failure recovery/notification actions:**
* Send message in slack channel in case of pipeline failure on any stage
* Set status of related Jira ticket to ‘To Do’

[Back to table of contents](#table-of-contents-description-of-all-pipeline-stages-by-execution-order)
