# Shell script for running JCL jobs on the mainframe via ftp

**runZosJcl.sh script is intended to execute job from z/OS dataset via ftp**

**Also, this Shell script template can be used as part of the Jenkins pipeline to automate the launch of JCL jobs.**

[**Link to shell script sources (runZosJcl.sh)**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/zOS%20DevOps%20Scripts/Shell%20script%20for%20running%20JCL%20jobs%20on%20the%20mainframe%20via%20ftp/runZosJcl.sh)

**Instructions:**

Execution format::
```
>./runZosJcl.sh [job] [output_file]
```

* `job` - fully-qualified job name in quotation marks
* `output_file` - file where job output log will be saved

Script returns 1 if dataset with JCL was not found or job failed (completed with error or RC>04) 

Example:
```
>./runZosJcl.sh 'USER01.TESTPROG.JCL(TEST)' build_output.txt
```