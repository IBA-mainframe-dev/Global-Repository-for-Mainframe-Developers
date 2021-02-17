# This solution solves the issue of packing and transferring data sets from one system to another in an automatic mode, using XMIT and ADRDSSU with return code checking via simple REXX script

**Steps for implementation:**
1. Allocate in your first system two JCL jobs and one REXX script with the appropriate content from the below datasets:
   * [JCL job - USER01.SAMPLE.JCL(SENDLIBS)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Batch%20jobs%20(JCLs)/Sample%20solution%20for%20transferring%20datasets%20using%20XMIT%20and%20ADRDSSU/USER01.SAMPLE.JCL/SENDLIBS.jcl)
   * [JCL job - USER01.SAMPLE.JCL(RECVLIBS)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Batch%20jobs%20(JCLs)/Sample%20solution%20for%20transferring%20datasets%20using%20XMIT%20and%20ADRDSSU/USER01.SAMPLE.JCL/RECVLIBS.jcl)
   * [REXX script - USER01.SAMPLE.EXEC(CHECKRC)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Batch%20jobs%20(JCLs)/Sample%20solution%20for%20transferring%20datasets%20using%20XMIT%20and%20ADRDSSU/USER01.SAMPLE.EXEC/CHECKRC.rexx)

**Description:**
   * SENDLIBS JCL job - for preparing and packing datasets for transferring and sending them to a remote system.
   * RECVLIBS JCL job - for receiving datasets on a remote system and unpacking them.
   * CHECKRC REXX script - for checking the return code from remote system job output.

2. After creating jobs, you need to replace the following places in the code:
   * All values enclosed in hashtags (example: `#value to change#`)
   * Change the job card to suit your system settings (an example of a job header that was used to launch is in the "INSTRUCTIONS" block, at the beginning of the code listing)
   
3. After changing all values in the code, execute USER01.SAMPLE.JCL(SENDLIBS) JCL job and check the execution result.
