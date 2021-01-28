# Shell script for datasets transfering from UNIX to the mainframe via ftp

**sendLIBS.sh was created to send source datasets to z/OS via ftp.**

[**Link to shell script sources (sendLIBS.sh)**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/zOS%20DevOps%20Scripts/Shell%20script%20for%20datasets%20transfering%20from%20UNIX%20to%20the%20mainframe%20via%20ftp/sendLIBS.sh)

**Script configuration before execution**
1. Prepare file which contains list of datasets LLQ (HLQ should be specified in the shell script parameters at startup) to be sent to z/OS. 
   Each dataset name is located in separate line, for example datasetsList file contains:
   ```
   TEST
   SAMPLIB
   JCL
   COBOL
   PLI
   ASM
   ```
   All libraries should be located in the current directory 
2. Replace the following values in the script:
* `HOST=#Mainframe IP-address here#`
* `USERID=#MF User#`
* `PASSWD=#User password#`
* `DSQ='#Script default HLQ qualifiers#'`

**Sequence of script actions:**
* Script receives an input file with list of datasets, required for transfering
* Sends datasets to z/OS

**Execution format:**
```
>./sendLIBS.sh [ds_list] [ds_qualifier] 
```
* `ds_qualifiers` - HLQ and MLQ datasets on z/OS
                          default: USER01.TEST

* `ds_list` - file which contains list of datasets to be sent to z/OS
                          each dataset name is located in separate line, for example:
                             TEST
                             ASM
                             COBOL
                          all libraries should be located in the current directory 


Script returns 1 if at least one directory/file was not found or dir/file transfer was unsuccessful.

**Execution examples:**
```
>./sendLIBS.sh dsList USER01.TEST
```