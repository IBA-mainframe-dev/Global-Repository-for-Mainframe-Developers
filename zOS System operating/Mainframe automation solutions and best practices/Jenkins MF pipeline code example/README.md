
# Jenkins MF pipeline code example

In this article, we want to give an example of a Jenkins Declarative Pipeline code, which implements the DevOps practices on the mainframe.

*NOTE:* This pipeline is an example and is in the process of improvement and development. If you have any suggestions or comments, you can open an issue or create a pull request.

Pipeline consists of 13 stages. Each stage is responsible for a specific scope of tasks.
<p align="center">
<img src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/images/mfarticleimages/Pipeline%20stages.png" width="900" alt="DevOps infinity ring">
</p>

### Jenkins plugins
Before starting work, for the pipeline execution, you will need pre-installed and pre-configured Jenkins plugins, such as:
1. Version control system you are using - GitHub, GitLab or Bitbucket
2. [Jira](https://plugins.jenkins.io/jira/)
3. [JIRA Pipeline Steps](https://plugins.jenkins.io/jira-steps/)
4. [JiraTestResultReporter](https://plugins.jenkins.io/JiraTestResultReporter/)
5. [Sonar Quality Gates Plugin (if you have a trial or full version)](https://plugins.jenkins.io/sonar-quality-gates/)
6. [SonarQube Scanner (if you have a trial or full version)](https://plugins.jenkins.io/sonar/)
7. [TestLink Plugin](https://plugins.jenkins.io/testlink/)

### Build Triggers
Pipeline is triggered by a webhook trigger with the git action you need (push/pull or merge requests, etc.). This trigger should be configured in **Build Triggers** pipeline section, using pre-installed and pre-configured Git plugins (for example GitHub, GitLab, Bitbucket plugins).
Commit message must contain Jira ticket ID which is used to document pipeline execution progress. See also example of commit to git repository from z/OS in the “Git for z/OS” section.

## Pipeline code example
You can find the entire pipeline code in a separate file or here in the article. Below we provide a description of each stage and its goals.

## Description of all pipeline stages by execution order :

Check code
This step is currently disabled due to missing license from software vendor
Steps :
•	Get Jira ticket Id from commit message
•	Get developer’s mail address and store it in Jenkins variable
•	Clone changed branch from git
•	Run SonarQube scanner to analyze code
•	Check analysis results vs quality gate conditions, set pipeline status accordingly

Failure recovery/notification actions :
•	Send e-mail to code developer


Build
Steps :
•	Get development branch name and store it in Jenkins variable
•	Clone master branch from git
•	Get scripts from git
•	Clone development branch from git
•	Get Jira ticket Id from commit message
•	Get developer’s mail address and store it in Jenkins variable
·	Get list of changed modules, store it in z/OS sequential dataset <project HLQ>.DIFF 
·	Save list of changed modules in changesList.txt file
·	Update z/OS work datasets with changed modules (script sendChangedSrc.sh)
·	Submit *BLD jobs to create object and load modules (script runZosJcl.sh)
·	Send message in slack channel about starting pipeline execution
·	Set status of related Jira ticket to ‘In Progress’

Failure recovery/notification actions :
•	Restore changed modules from master branch
•	Send e-mail to code developer

Docker build
Steps :
•		Docker login
•	Build docker image for dvassproject/test. It is used to run unit, functional and integration tests in docker container.
•	Build docker image for dvassproject/python to run python-component in docker container as a part of test phase.
•	Push docker images to dockerhub (step is currently disabled)

Failure recovery/notification actions :
•	Restore changed modules from master branch
•	Send e-mail to test developer

Unit tests
Steps :
•	Run unit tests/suites from git repository ‘test’
•	Results are stored in one of test management systems - TestLink or TestRail

Failure recovery/notification actions :
•	Restore changed modules from master branch
•	Send e-mail to test developer

Prepare input data for PTF
Steps :
•	Submit CRTSTAGE job (script runZosJcl.sh), it executes  REXX program CRTESTG that creates set of stage libraries

Failure recovery/notification actions :
•	Restore changed modules from master branch
•	Send e-mail to SMP/E packaging team

Build PTF
Steps:
•		Submit PTFBLD job (script runZosJcl.sh), it executes REXX program PTFGEN that builds APARfix/PTF dataset from stage libraries

Failure recovery/notification actions :
•	Restore changed modules from master branch
•	Send e-mail to SMP/E packaging team

Receive PTF
Steps :
•		Submit RECVPTF job (script runZosJcl.sh), it loads APARfix/PTF information into SMP/E global zone by RECEIVE command

Failure recovery/notification actions :
•	Restore changed modules from master branch
•	Send e-mail to SMP/E packaging team



Apply PTF
Steps :
•	Submit APPLYPTF job (script runZosJcl.sh) that installs APARfix/PTF into the SMP/E target zone by APPLY command

Failure recovery/notification actions :
•	Reject PTF from SMP/E global zone by REJCTPTF job 
•	Restore changed modules from master branch
•	Send e-mail to SMP/E packaging team
•	Open environment issue in GitLab
