# Shell script for transferring changed sources in git to the mainframe via ftp

** sendChangedScr.sh was created to send changed sources to z/OS via ftp **

[**Link to shell script sources (sendChangedSrc.sh)**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/zOS%20DevOps%20Scripts/Shell%20script%20for%20transferring%20changed%20sources%20in%20git%20to%20the%20mainframe%20via%20ftp/sendChangedSrc.sh)

** Script configuration before execution **
1. Prepare configuration file `vardefs` by replacing the following values:
* `HOST=#Mainframe IP-address here#`
* `USERID=#MF User#`
* `USERPSW=#User password#`
* `defaultHLQ='#HLQ of datasets#'`
* `masterBranch=#master branch name#`
* `developBranch=#develop branch name#`

2. Replace the path to the configuration file in the script:
* `VAR_PATH="/$PWD/#PATH TO CONFIG#/vardefs"`

**Sequence of script actions:**
* Script retrieves list of modified modules from git
* Sends modules to z/OS
* Puts list of modified modules in [HLQ].DIFF dataset on z/OS
  
**Execution format:**
```
>./sendChangedSrc.sh [HLQ] [restore] 
```
* `HLQ` - datasets qualifiers, required parameter

* `restore` - constant value which must be specified to restore changed modules from master branch in case of errors

Script returns 1 if HLQ was not specified, changed modules list is empty or file transfer was unsuccessful.

**Execution examples:**
```
>./sendChangedScr.sh USER01.TEST

>./"$PWD"/scripts/zOS/sendChangedScr.sh USER01.TEST restore
```
