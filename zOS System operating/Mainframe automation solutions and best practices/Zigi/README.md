# Zigi

## About

Zigi is a freeware ISPF front-end tool for z/OS Git client. 
Written in REXX, provides user-friendly ISPF interface and transparent usage of native z/OS filesystem 
for handling local repositories.

Using Git with configured webhooks and zigi as ISPF Git client allows automate the code development process 
for mainframes and include it to CI/CD. 

**Link to Zigi github repository:** [https://github.com/wizardofzos/zigi](https://github.com/wizardofzos/zigi)

## Installation

1. Install GIT on z/OS: download and install the Git package from Rocket Software. 
   Go to [https://www.rocketsoftware.com/product-categories/mainframe/git-for-zos](https://www.rocketsoftware.com/product-categories/mainframe/git-for-zos) to get started.
2. From USS run the command to clone zigi-repository:

```
git clone git://github.com/wizardofzos/zigi.git
```

3. Run the script

```
cd zigi
./zginstall.rex
```

## Usage
1. Execute REXX-script ZIGI from ZIGI.EXEC to start working:

 Run command 

![alt text](img/zigi-exec1.png "Run ZIGI option1")

 Or using 3.4, browse to the PDS USR.ZIGI.EXEC and enter EX for the member ZIGI, press enter:
 
![alt text](img/zigi-exec2.png "Run ZIGI option2")


2. Clone Git-repository to z/Os

Copy SSH-link from Git-repository and fill the fields in the panel:
![alt text](img/zigi-clone.png "Clone Git-repository")


3. Add to index

![alt text](img/zigi-add-to-index.png "Add to index")


4. Commit changes

![alt text](img/zigi-commit1.png "Commit1")

![alt text](img/zigi-commit2.png "Commit2")

![alt text](img/zigi-commit3.png "Commit3")


5. Push changes to remote repository

![alt text](img/zigi-push1.png "Push")


5. The list of commands for local repository:
![alt text](img/zigi-local.png "Commands for local")

6. The list of commands for remote repository:
![alt text](img/zigi-remote.png "Commands for remote")
