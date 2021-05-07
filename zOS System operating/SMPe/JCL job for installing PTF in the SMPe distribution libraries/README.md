# JCL job to install PTF in the SMP/e distribution libraries

**`ACCPTPTF` - This JCL job is used to install PTF in the SMP/E `DISTRIBUTION libraries`**

[**Link to clone/download from the repository**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20installing%20PTF%20in%20the%20SMPe%20distribution%20libraries/ACCPTPTF)

```
//ACCPTPTF   JOB <JOB PARAMETERS>    
//*----------------------------------------------------    
//*  THIS JOB IS USED TO INSTALL PTF IN THE SMP/E 
//*  DISTRIBUTION LIBRARIES 
//*
//*  INSTRUCTIONS:
//*  CHANGE SMPEHLQ TO THE HLQ YOU NEED
//*  CHANGE PTFNAME WITH YOUR PTF NAME
//*
//*----------------------------------------------------
//EX EXPORT SYMLIST=(SMPEHLQ,PTFNAME,SPACE3)  
// SET SMPEHLQ=#SMPE HLQ#
// SET PTFNAME=#PTF NAME HERE#
// SET SPACE3='UNIT=VIO,SPACE=(CYL,(5,1,8))'
//*                               
//*---------------------------------------------------------------------
//*  THIS JOB ACCEPTS PTF                                               
//*---------------------------------------------------------------------
//ACPTPTF  EXEC PGM=GIMSMP,REGION=0M                                    
//SMPLOG   DD SYSOUT=*                                                  
//SMPLOGA  DD SYSOUT=*                                                  
//SMPCSI   DD DSN=&SMPEHLQ..GB.CSI,DISP=SHR                             
//SYSUT1   DD &SPACE3                                                   
//SYSUT2   DD &SPACE3                                                   
//SYSUT3   DD &SPACE3                                                   
//SYSUT4   DD &SPACE3                                                   
//SMPWRK1  DD &SPACE3                                                   
//SMPWRK2  DD &SPACE3                                                   
//SMPWRK3  DD &SPACE3                                                   
//SMPWRK4  DD &SPACE3                                                   
//SMPWRK5  DD &SPACE3                                                   
//SMPWRK6  DD &SPACE3      
//SMPOUT   DD SYSOUT=*                  
//SMPRPT   DD SYSOUT=*                  
//SMPLIST  DD SYSOUT=*                  
//SYSPRINT DD SYSOUT=*                  
//SMPCNTL  DD  *,SYMBOLS=(JCLONLY,SUBST)
 SET BDY (DZONE).                       
 ACCEPT CHECK SELECT(&PTFNAME.) .       
/*                                 
```