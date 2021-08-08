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
                    git branch: 'zigi-master', credentialsId: '5ca6df5c-fd7d-42b1-a0d1-dd8bf947ccd3', 
                    url: 'https://git.icdc.io/dvass-project-group/program.git'
                }
                dir('script') {
                    git branch: 'master', credentialsId: '5ca6df5c-fd7d-42b1-a0d1-dd8bf947ccd3',
                    url: 'https://git.icdc.io/dvass-project-group/script.git'
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
                
                git branch: "${BRANCH}", credentialsId: '5ca6df5c-fd7d-42b1-a0d1-dd8bf947ccd3', 
                url: 'https://git.icdc.io/dvass-project-group/program.git'
                
                script { emaildev = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%ae\'')   }
                echo "${emaildev}"  
                script { jiraID = sh(returnStdout: true, script: 'git log -1 --pretty=%B | grep -o "DVASS-[0-9][0-9]*"').trim()  }
                echo "${jiraID}"
         
                jiraTransitionIssue idOrKey: "${jiraID}", input: transitionInProgress, site: "${jiraSite}"
                jiraAddComment idOrKey: "${jiraID}", comment: 'Jenkins Pipeline is started', site: "${jiraSite}"
                
                //Send changed sources on z/OS
                sh  " ./sendChangedSrc.sh  ${HLQ}"
                
                //Run build JCLs - create object and load modules
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
                        openBug = sh(returnStdout: true, script: "curl -X POST --header \"PRIVATE-TOKEN: ${gitToken}\" --header \"Content-Type: application/json\" -d '${json}' \"https://git.icdc.io/api/v4/projects/${gitRepId}/issues\"")
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
                        openBug = sh(returnStdout: true, script: "curl -X POST --header \"PRIVATE-TOKEN: ${gitToken}\" --header \"Content-Type: application/json\" -d '${json}' \"https://git.icdc.io/api/v4/projects/${gitRepId}/issues\"")
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
                        openBug = sh(returnStdout: true, script: "curl -X POST --header \"PRIVATE-TOKEN: ${gitToken}\" --header \"Content-Type: application/json\" -d '${json}' \"https://git.icdc.io/api/v4/projects/${gitRepId}/issues\"")
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
                   git branch: 'master', credentialsId: '5ca6df5c-fd7d-42b1-a0d1-dd8bf947ccd3',
                   url: 'https://git.icdc.io/dvass-project-group/script.git'
                } 
            sh '''
                cp $PWD/script/Jira/attachPTFdocs/attachPTFdocs.sh  attachPTFdocs.sh 
            '''
            withCredentials([usernamePassword(credentialsId: '5ca6df5c-fd7d-42b1-a0d1-dd8bf947ccd3', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
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

