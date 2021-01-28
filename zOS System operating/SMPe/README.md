# This directory contains sets of solutions for automating PTF assemblies and working with SMP/E

**List of automated solutions templates:**
1. [Automated build PTF via JCL + REXX template](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/Automated-build-PTF-via-JCL---REXX-template)
2. [JCL job for loading PTF information into global zone and SMPe datasets](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-loading-PTF-information-into-global-zone-and-SMPe-datasets)
3. [JCL job for installing PTF in the SMPe target libraries](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-installing-PTF-in-the-SMPe-target-libraries)
4. [JCL job for installing PTF in the SMPe distribution libraries](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-installing-PTF-in-the-SMPe-distribution-libraries)
5. [JCL job for rejecting PTF to clean up the global zone](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-rejecting-PTF-to-clean-up-the-global-zone)
6. [JCL job for restoring PTF to clean up the target zone](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-restoring-PTF-to-clean-up-the-target-zone)
 
## Detailed description:

**Instructions for adapting each JCL job or REXX script to your parameters are inside of each file**
1. [**Automated build PTF via JCL + REXX template**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/Automated-build-PTF-via-JCL---REXX-template) - This solution consists of JCL job, that execute REXX program that builds PTF dataset from input libraries

     [PTFBLD JCL job](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/Automated%20build%20PTF%20via%20JCL%20%2B%20REXX%20template/PTFBLD) - launches REXX script

     [USER01.SAMPLE.REXX(PTFGEN)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/Automated%20build%20PTF%20via%20JCL%20%2B%20REXX%20template/USER01.SAMPLE.REXX/PTFGEN) - REXX program that builds PTF dataset from input libraries

2. [**JCL job for loading PTF information into global zone and SMPe datasets**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-loading-PTF-information-into-global-zone-and-SMPe-datasets)

     [RECVPTF](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20loading%20PTF%20information%20into%20global%20zone%20and%20SMPe%20datasets/RECVPTF) - This JCL job is used to load PTF information into `GLOBAL ZONE` and SMP/E datasets

3. [**JCL job for installing PTF in the SMPe target libraries**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-installing-PTF-in-the-SMPe-target-libraries)

     [APPLYPTF](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20target%20libraries/APPLYPTF) - This JCL job is used to install PTF in the SMP/E `TARGET libraries`

4. [**JCL job for installing PTF in the SMPe distribution libraries**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-installing-PTF-in-the-SMPe-distribution-libraries)

     [ACCPTPTF](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20distribution%20libraries/ACCPTPTF) - This JCL job is used to install PTF in the SMP/E `DISTRIBUTION libraries`

5. [**JCL job for rejecting PTF to clean up the global zone**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-rejecting-PTF-to-clean-up-the-global-zone)

     [REJCTPTF](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20rejecting%20PTF%20to%20clean%20up%20the%20global%20zone/REJCTPTF) - This JCL job is used to reject PTF to clean up the `GLOBAL ZONE`
     
6. [**JCL job for restoring PTF to clean up the target zone**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/wiki/JCL-job-for-restoring-PTF-to-clean-up-the-target-zone)

     [RESTRPTF](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20restoring%20PTF%20to%20clean%20up%20the%20target%20zone/RESTRPTF) - This JCL job is used to restore PTF to clean up the `TARGET ZONE`
