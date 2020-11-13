# This directory contains sets of solutions for automating PTF assemblies and working with SMP/E

**List of automated solutions templates:**
1. [Automated build PTF via JCL + REXX template](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/tree/master/SMPe/Automated%20build%20PTF%20via%20JCL%20%2B%20REXX%20template)
2. [JCL job for loading PTF information into global zone and SMPe datasets](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20loading%20PTF%20information%20into%20global%20zone%20and%20SMPe%20datasets/RECVPTF)
3. [JCL job for installing PTF in the SMPe target libraries](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20target%20libraries/APPLYPTF)
4. [JCL job for installing PTF in the SMPe distribution libraries](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20distribution%20libraries/ACCPTPTF)
5. [JCL job for rejecting PTF to clean up the global zone](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20rejecting%20PTF%20to%20clean%20up%20the%20global%20zone/REJCTPTF)
6. [JCL job for restoring PTF to clean up the target zone](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20restoring%20PTF%20to%20clean%20up%20the%20target%20zone/RESTRPTF)
 
## Detailed description:

**Instructions for adapting each JCL job or REXX script to your parameters are inside of each file**
1. [**Automated build PTF via JCL + REXX template**](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/tree/master/SMPe/Automated%20build%20PTF%20via%20JCL%20%2B%20REXX%20template) - This solution consists of JCL job, that execute REXX program that builds PTF dataset from input libraries

     [PTFBLD JCL job](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/Automated%20build%20PTF%20via%20JCL%20+%20REXX%20template/PTFBLD) - launches REXX script

     [USER01.SAMPLE.REXX(PTFGEN)](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/Automated%20build%20PTF%20via%20JCL%20+%20REXX%20template/USER01.SAMPLE.REXX/PTFGEN) - REXX program that builds PTF dataset from input libraries

2. [**JCL job for loading PTF information into global zone and SMPe datasets**](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20loading%20PTF%20information%20into%20global%20zone%20and%20SMPe%20datasets/RECVPTF)

     [RECVPTF](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20loading%20PTF%20information%20into%20global%20zone%20and%20SMPe%20datasets/RECVPTF) - This JCL job is used to load PTF information into `GLOBAL ZONE` and SMP/E datasets

3. [**JCL job for installing PTF in the SMPe target libraries**](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20target%20libraries/APPLYPTF)

     [APPLYPTF](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20target%20libraries/APPLYPTF) - This JCL job is used to install PTF in the SMP/E `TARGET libraries`

4. [**JCL job for installing PTF in the SMPe distribution libraries**](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20distribution%20libraries/ACCPTPTF)

     [ACCPTPTF](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20distribution%20libraries/ACCPTPTF) - This JCL job is used to install PTF in the SMP/E `DISTRIBUTION libraries`

5. [**JCL job for rejecting PTF to clean up the global zone**](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20rejecting%20PTF%20to%20clean%20up%20the%20global%20zone/REJCTPTF)

     [REJCTPTF](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20rejecting%20PTF%20to%20clean%20up%20the%20global%20zone/REJCTPTF) - This JCL job is used to reject PTF to clean up the `GLOBAL ZONE`
     
6. [**JCL job for restoring PTF to clean up the target zone**](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20restoring%20PTF%20to%20clean%20up%20the%20target%20zone/RESTRPTF)

     [RESTRPTF](https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/SMPe/JCL%20job%20for%20restoring%20PTF%20to%20clean%20up%20the%20target%20zone/RESTRPTF) - This JCL job is used to restore PTF to clean up the `TARGET ZONE`



