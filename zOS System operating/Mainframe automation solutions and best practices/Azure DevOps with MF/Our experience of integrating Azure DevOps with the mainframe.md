# Our experience of integrating Azure DevOps with the mainframe

<img align="right" width="300" src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Azure%20DevOps%20with%20MF/images/MS_Azure_Logo.png" alt="MS Azure Logo" />

### We would like to share with you our experience of using Azure DevOps services and integrating them with the mainframe.
We tried to use Azure DevOps as an alternative to the Jenkins CI/СD orchestrator.

Azure DevOps is Microsoft service which allows to build pipelines, maintain board and maintain git repositories in one product. Also it has a lot of plugins for pipelines. This product is suitable for those users who don’t want to use several products for CI/CD (Jira, Jenkins, etc.), or who want/have to interact with Microsoft products.
Azure DevOps provides integrated features that you can access through your web browser or IDE client. You can use one or more of the following standalone services based on your needs:

* **Azure Repos** provides Git repositories or Team Foundation Version Control (TFVC) for source control of your code.
* **Azure Pipelines** provides build and release services to support continuous integration and delivery of your applications.
* **Azure Boards** delivers a suite of Agile tools to support planning and tracking work, code defects, and issues using Kanban and Scrum methods.
* **Azure Test Plans** provides several tools to test your apps, including automated/manual/exploratory testing and continuous testing.
* **Azure Artifacts** allows teams to share packages such as Maven, npm, NuGet, and more from public and private sources and integrate package sharing into your pipelines.

You can also use the following collaboration tools:
* Customizable team dashboards with configurable widgets to share information, progress, and trends
* Built-in wikis for sharing information
* Configurable notifications
* Azure DevOps supports adding extensions and integrating with other popular services, such as: GitHub, Campfire, Slack, Trello, UserVoice, and more, and developing your own custom extensions.

Azure Devops can be used as a cloud or server solution and includes its own services as **alternatives to CI/СD tools (Azure Pipelines)**, **issue tracking systems (Azure Boards)**, **version control systems (local git - Azure Repos)**, **test managment system (Azure Test Plans)** and an alternative **repository of artifacts (Azure Artifacts)**.
We are particularly interested in trying to use this local tool stack, especially Azure Pipelines for our CI/CD orchestrator tool, Azure Boards for issue and bugs tracking, Asure Repos as alternative to other version control systems for better integration and Azure Test Plans for tests managment.

## Usage example
<img align="right" width="500" src="https://github.com/Dereliass/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Azure%20DevOps%20with%20MF/images/Pipeline_examples.png" alt="Pipelines" />
First of all, there are 2 types of pipeline - YAML and GUI. GUI is much easier to create and maintain, YAML - pipeline in form of code (analog of Groovy on Jenkins), it is saved not only on Azure service, but also in git repository (Github for example), and every change of pipeline makes commit, also it is more flexible than GUI.


Then it is necessary to attach one (and only one) git repository to pipeline, this repository will be cloned by pipeline automatically, and path of this repository will be “super” for execution of pipeline.


<img align="right" width="500" src="https://github.com/Dereliass/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Azure%20DevOps%20with%20MF/images/Linux_agent.png" alt="Pipelines" />
Also very important difference of Azure DevOps: when Jenkins is installed on machine (in our case - Ubuntu Server), it’s just running on it, DevOps Azure pipelines - can be run on every machine. It has concepts “agents” and “pools”. Agent is folder on some machine, there is a script which is a part of agent, this script is run on machine, it allows machine to “listen” for request to execute pipeline on this agent. 


This folder also is a workspace for pipelines (for this particular agent). Pool is set of agents, the features of pool aren’t important, because it concerns multi-agent and multi-thread pipeline execution.
Agent should be in online state (script is running) to be able to execute pipeline.


**Also, to integrate with other services and to automate some of the actions of azur devops, we used Azure CLI commands in our pipelines.**
You can find a full description of all services and commands for interacting with them in the official documentation: https://docs.microsoft.com/en-us/cli/azure/ext/azure-devops/devops?view=azure-cli-latest

## Below we will give an example of Azure DevOps pipeline, its structure and approaches:
```
# DevOps Example pipeline

variables:
  - name: testRepoURL
    value: 
  - name: scriptsRepoURL
    value: 
  - name: testsRepoURL
    value: 
  - name: programRepoURL
    value: 
  - name: HLQ
    value: USER01.TESTPROG
  - name: JCLLIB
    value: USER01.TESTPROG.JCL
  - name: boardItemID
    value: 
  - name: transitionInProgress
    value: Doing 
  - name: transitionDone
    value: Done
  - name: addingNewComment
    value: Adding new comment

jobs:
- job: Build
  pool: LinuxRemotePool
  steps:
  - checkout: self
    persistCredentials: true
  - task: CmdLine@2
    inputs:
      script: 'echo "<TOKEN_HERE>" > my_pat_token.txt'
  - task: CmdLine@2
    inputs:
      script: 'cat my_pat_token.txt | az devops login --organization <URL to your project>'

  # save current location to programRepo variable
  - script: |
      cd ..
      mkdir git
      cd git
      rm -rf script
      git clone $(scriptsRepoURL)
      ls
      cd script
      echo $PWD - pwd
      echo $(scriptRepo) - scriptRepo
      ls
      cd AzureAttachment
      pwd
      javac -cp json.jar:codec.jar:io.jar -source 8 -target 8 AttachmentToAzure.java
    displayName: Config script Repo
  - script: |
      cd ..
      cd git
      rm -rf test
      git clone $(testsRepoURL) 
      ls
      cd test
      echo $PWD - pwd
      echo $(testsRepo) - testsRepo
    displayName: Config test Repo
  
  - script: |
      cd ..
      cd git
      rm -rf develop
      git clone --branch=develop $(testRepoURL) ./develop
      cd develop
      git clone --branch=zigi-master $(testRepoURL) ./master
      cd ..

      cp $PWD/script/zOS/sendChangedSrc.sh develop/sendChangedSrc.sh
      cp $PWD/script/zOS/runZosJcl.sh develop/runZosJcl.sh
      cp $PWD/script/config/setBranch.sh develop/setBranch.sh
      cp -r $PWD/script/config $PWD/develop
    displayName: Config develop Repo

  #Update issue state
  - task: CmdLine@2
    inputs:
      script: 'az boards work-item update --organization <URL to your project> --id $(boardItemID) --state $(transitionInProgress)'
  #Add issue comment
  - task: CmdLine@2
    inputs:
      script: 'az boards work-item update --organization <URL to your project> --id $(boardItemID) --discussion "Azure Pipeline is started"'

  - script: |
      cd $(developBranchRepo)
      sh $(developBranchRepo)/sendChangedSrc.sh  $(HLQ)
      sh $(developBranchRepo)/runZosJcl.sh  $(JCLLIB)\(ALLLIBS\) alloclibs.log
      sh $(developBranchRepo)/runZosJcl.sh  $(JCLLIB)\(ASSEMBLD\) assem_bld.log
      sh $(developBranchRepo)/runZosJcl.sh  $(JCLLIB)\(COBOLBLD\) cobol_bld.log
      sh $(developBranchRepo)/runZosJcl.sh  $(JCLLIB)\(PLIBLD\) pli_bld.log
    displayName: Setup environment

  - task: CmdLine@2
    condition: succeeded()
    inputs:
      script: 'az boards work-item update --organization <URL to your project> --id $(boardItemID) --discussion "Build stage completed successfully"'

  - task: CmdLine@2
    condition: failed()
    inputs:
      script: |
        cd $(developBranchRepo)
        sh $(developBranchRepo)/sendChangedSrc.sh $(HLQ) restore
  - task: servbus.SendMail4VSTS.SendMail4VSTS.SendEmail@0
    displayName: 'Send an email with subject Start Build Failed'
    condition: failed()
    inputs:
      To: 'user@email.eu'
      From: 'user@email.com'
      Subject: 'Build failed'
      Body: 'Build stage failed. See attached pipeline log.'
      SmtpServer: smtp.gmail.com
      SmtpUsername: 'user@email.com'
      SmtpPassword: 
      STARTTLS: true
      #Add issue comment
      script: 'az boards work-item update --organization <URL to your project> --id $(boardItemID) --discussion "Build stage failed"'

```

