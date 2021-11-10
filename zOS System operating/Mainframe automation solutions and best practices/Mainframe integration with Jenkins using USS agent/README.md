# How to Connect Mainframe with Jenkins Pipelines Using USS*
 
In this article, we will give you a good, functional solution to the issue of how to bring DevOps to mainframe software development. 
And we will provide a concrete example of our approach, and walk you through how to connect a mainframe with Jenkins pipeline using USS.

By doing this, you can implement all of the DevOps best practices, transformative practices like Continuous Delivery/Continuous Integration (CICD), and automate many steps of your work, including:
 
-   Automated builds
-   Automated (and consistent) deployment
-   Automated testing
-   Automated code quality verification
-   Automated monitoring
 
While everyone has their own unique mainframe with its own unique challenges to overcome, we will show you that you don’t need a unique solution to do so. We will show you how a general-purpose tool like Jenkins can solve most of your problems and automate many of your manual mainframe processes — fast, simple and easy.

## Meet Jenkins: A General-Purpose DevOps Tool that Works Great with Mainframe
 
Jenkins is an existing general-purpose DevOps tool. In simple terms, it is an open-source automation server that makes it easy to automate many tasks related to developing, testing, and deploying software.
 
Jenkins brings a lot of benefits to mainframe software development, especially compared to creating a homegrown solution. Jenkins:
-  Has already solved many automation problems and can automate many tasks for almost any solution, regardless of the scope of the solution’s infrastructure.
-  Was developed to coordinate software building, testing, and deployment processes across multiple processes across multiple platforms.
-  Has a huge number of plugins and integrations, extending its reach.
-  Uses groovy scripting-based pipelines.
-  Uses REST API to allow information feedback and pipeline triggering.
-  Offers most of these capabilities out-of-the-box.

Most important, Jenkins is an active open-source project with a large and engaged community. It already has a lot of documentation, examples, and support, and the tool is well-maintained and constantly expanding to tackle new automation challenges.
 
In sum: Jenkins makes it fast, simple, and easy to bring a lot of DevOps practices to mainframe software development. It’s a great example of how you can save yourself a lot of time, effort and budget by using a general-purpose DevOps tool instead of a homegrown solution, and it’s worth finding a way to bring it to mainframe environments.

## How to Bring Jenkins to Mainframe: Imperfect Options
 
So far, the world of mainframe hasn’t produced a definitive answer on how to best connect Jenkins to mainframe environments. Instead, most teams are using one of three imperfect options. These options are:
-   Running Jenkins directly on mainframe
-   Using the IBM z/OS Plugin for Jenkins
-   Building custom solutions
 
### Option One: Running Jenkins directly on mainframe
 
Jenkins was not built to be mainframe-native, and it does not run very well when it’s run directly on a mainframe. Specifically:
 
-   It requires a lot of very expensive CPU time.
-   Other external services need to be available at the same time as Jenkins and you must find somewhere to keep them.
-   You need to open additional access for external services, which is costly and unreasonably difficult, and creates additional security challenges.
 
Due to these challenges, among others, teams shouldn’t run Jenkins on their mainframe itself. Instead, they should keep Jenkins an external service that they run on a separate server.
 
Of course, running Jenkins as an external service creates a new challenge — how to make contact between Jenkins and the mainframe. Options two and three attempt to provide a solution to this challenge.
 
### Option Two: Using the IBM z/OS Plugin for Jenkins
 
As a whole, this plugin is a good solution to connect Jenkins and mainframe. It provides rich functionality to automate some processes and it provides the ability to perform some mainframe-specific actions (like running JES jobs).
 
However, this plugin has some limitations. It only allows you to use Jenkins to interact with the mainframe SCLM. While this makes it a good solution if you are still storing SCLM on the mainframe, most modern teams have abandoned SCLM and now work through GitHub, BitBucket, or other similar services — which makes this plugin obsolete for many teams.
 
### Option Three: Building Custom Solutions
 
Finally, some teams choose to build a homegrown solution to connect Jenkins with the mainframe, either by cobbling together third party applications or by creating something from scratch. While creating a custom solution will give teams some very good experience developing solutions, it is not an easy path, it is totally unnecessary, as we are about to see.
 
Overall, while both of these methods have been useful, they are just too complicated, too time-intensive, and too high-effort to be used at scale. Mainframe software development teams need a modern and proven solution to connect Jenkins with mainframe — and we have developed that better approach.

<p align="right">
<img src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/images/mfarticleimages/image1.png" width="600" alt="Semi-automated">
</p>
 
## Best Solution: A Simpler Way to Connect Jenkins to Mainframe
 
To be clear — in the past we have made every possible mistake as we tried to connect Jenkins and mainframe. We initially created a custom solution with a lot of homegrown adapters and connectors. Our solution worked well enough, but, eventually, we realized there was a much simpler way to connect the two systems.

One day, we read carefully through Jenkins’ documentation. We learned that Jenkins already had some useful tools in its existing implementation methods. We realized we could use those tools to connect Jenkins to the mainframe in just a couple of steps and without developing any new plugins, simply by using the existing Jenkins agent.
 
The Jenkins agent is just a Java program that runs under USS. The Jenkins controller is the original node in the installation, and the controller administers the Jenkins agent and orchestrates its working, including scheduling jobs on the agent and monitoring them.
 
This agent can be connected to the Jenkins controller using either local or cloud computers. All it needs is a Java installation and a network connection to the Jenkins controller, and it provides a simple way to connect Jenkins and mainframe.

<p align="center">
<img src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/image1.png" width="600" alt="DevOps infinity ring">
</p>
 
Once we learned how to use the Jenkins agent, we never looked back at plugins or custom solutions. This agent gave us a simple, straightforward approach that delivered many benefits. Specifically, we learned that this agent is:
 
-   **Self-sufficient.** You don’t need to install any additional tools on the mainframe, except the Java program to make everything work.
-   **Lightweight and simple.** This solution will not take up too much disk space, and it will not overload the processor with a lot of work.
-   **Not loaded with business logic.** It is  just a simple automation tool, which allows you to implement it and abandon it very quickly and easily.
-   **Secure.** With this agent you are implementing automation into the mainframe with minimal external dependencies and a small impact on security.

Of course, the Jenkins agent is not perfect, and it does have some limitations. You won’t be able to perform certain tasks on the mainframe other than basic access to it, and it requires Java on USS. But it is no problem to put Java on USS and the problem of implementing more serious tasks has long been solved by other external components. Ultimately, the limitations of this approach are much, much smaller than the benefits you will gain by using agents to connect Jenkins to your mainframe.
 
Now, let’s dig into the details of how this approach works, and how you can connect the Jenkins agent to your mainframe as quickly and easily as possible.
 
## How to Connect the Jenkins Agent to Mainframe: Step-by-Step
 
Thankfully, you only need to solve a few problems to use the Jenkins agent to connect Jenkins to a mainframe environment. Specifically, you need to:
 
-   Have Java under USS
-   Open access so the agent and Java can interact
-   Configure your initial settings in Jenkins
-   And manage the agent through Jenkins

Most of these challenges — and most other challenges that you might encounter — already have a simple solution developed. You can find these solutions and more by reading through Jenkins’ existing documentation, which you can find here:
-   https://www.jenkins.io/doc/book/using/using-agents/
-   https://github.com/jenkinsci/remoting/blob/master/docs/inbound-agent.md
 
To get you started even faster and easier, here’s the exact step-by-step approach that our team uses. Our team has followed this approach to connect Jenkins to the mainframe on the real project for the last two years. These steps give you a simple and time-effective way to set up and interact with components.
 
### First, here are the steps to create the agent and insert it in USS
 
There are two ways to connect Jenkins from the mainframe to a Jenkins that’s running on a Linux server. Here’s the first way, that works but is not the best option.
 
1.  Open Jenkins, go to the Nodes tab, where you will find all of your mainframe nodes, where Jenkins is running in the mainframe’s USS.  
2.  To run Jenkins on the mainframe, click to create a new node, make it a permanent agent, and fill out the name and description nodes.
3.  Assuming Java is installed in the mainframe, create an SSH connection, place a remote root directory, the directory of the user Jenkins in mainframe where the agent performs its work. This is the place Jenkins jobs, files, and stores on the mainframe side. Our directory on the USS side on the mainframe.
4.  Choose “Launch agent by connecting it to the master.”
5.  Save the node and Jenkins will automatically prepare a command line to run on the mainframe side.
6.  In the mainframe, change the current user to Jenkins. Find the Jenkins workspace. You will find all Jenkins directories related to sources and scripts and so on.
7.  Draw on the command, and Jenkins will automatically connect from the mainframe and the agent will connect to the Jenkins node.  
 

While this method works, it will sometimes trigger some problems in Jenkins and force Jenkins to restart. Here’s a better way to connect the Jenkins agent to Jenkins by an SSH connection.
 
1.  Create another node with its launch method set as “Launch agent via SSH”, host address as the address of your mainframe, credentials to connect to the mainframe and authorize on it, and place the SSH port and Java path for the USS services on the mainframe.
2.  If all of your SSH keys are valid you can click the launch button in Jenkins, and Jenkins on itself will initiate the connection with the agent on the mainframe.
 

### Second, here are the steps to use your agent to connect Jenkins and mainframe.
 
1.  Go to the Jenkins web panel and set up your configuration to establish connections to the outside world.  
2.  Start your agent — either through the Jenkins web interface to launch it through USS, or to manually start the agent (if you don’t want Jenkins to make certain actions on your users’ mainframe).
3.  If you configured your agent correctly, then the agent will throw the message to Jenkins that it’s ready to work and to acquire commands, and Jenkins will send commands back to the agent.
 

### Third, here are the steps in a common use case — automating build, test, deploy
 
1.  Make changes to your code in your IDE.
2.  Make some commits to GitHub, or your other version control system.
3.  Use web hooks to send everything required to Jenkins.
4.  Start the pipeline that includes the Jenkins agent. This will grab everything from the GitHub commit, performs the automation, and sends everything to the end users.
