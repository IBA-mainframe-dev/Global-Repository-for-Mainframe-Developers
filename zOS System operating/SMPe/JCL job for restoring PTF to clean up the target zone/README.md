# JCL job for restoring PTF to clean up the target zone

**`RESTRPTF` - This JCL job is used to restore PTF to clean up the `TARGET ZONE`**

[**Link to clone/download from the repository**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20restoring%20PTF%20to%20clean%20up%20the%20target%20zone/RESTRPTF)

```
//RESTRPTF   JOB <JOB PARAMETERS>    
//*----------------------------------------------------    
//*  THIS JOB IS USED TO RESTORE PTF TO CLEAN UP 
//*  THE TARGET ZONE
//*
//*  INSTRUCTIONS:
//*  CHANGE SMPEHLQ TO THE HLQ YOU NEED
//*  CHANGE PTFNAME WITH YOUR PTF NAME
//*
//*----------------------------------------------------
//EX EXPORT SYMLIST=(SMPEHLQ,PTFNAME,SPACE3)  
// SET SMPEHLQ=#SMPE HLQ#
// SET PTFNAME=#PTF NAME HLQ#
// SET SPACE3='UNIT=VIO,SPACE=(CYL,(5,1,8))'
//*                
//*---------------------------------------------------------------------
//*  THIS JOB RESTORES PTF                                              
//*---------------------------------------------------------------------
//RESTPTF  EXEC PGM=GIMSMP,COND=(0,NE),REGION=0M                        
//SMPLOG   DD SYSOUT=*                                                  
//SMPLOGA  DD SYSOUT=*                                                  
//SMPCSI   DD DSN=&SMPEHLQ..GB.CSI,DISP=SHR                             
//SMPMTS   DD DSN=&SMPEHLQ..SMPMTS,DISP=SHR                             
//SMPPTS   DD DSN=&SMPEHLQ..SMPPTS,DISP=SHR                             
//SMPSCDS  DD DSN=&SMPEHLQ..SMPSCDS,DISP=SHR                            
//SMPSTS   DD DSN=&SMPEHLQ..SMPSTS,DISP=SHR                             
//SYSUT1   DD &SPACE3                                                   
//SYSUT2   DD &SPACE3                                                   
//SYSUT3   DD &SPACE3                                                   
//SYSUT4   DD &SPACE3                                                   
//SMPWRK1  DD &SPACE3                                                   
//SMPWRK2  DD &SPACE3                                                   
//SMPWRK3  DD &SPACE3                                                   
//SMPWRK4  DD &SPACE3                                                   
//SMPOUT   DD SYSOUT=*                                                  
//SMPRPT   DD SYSOUT=*                                                  
//SMPLIST  DD SYSOUT=*                                                  
//SYSPRINT DD SYSOUT=*                                                  
//SMPCNTL  DD  *,SYMBOLS=(JCLONLY,SUBST)     
 SET BDY (TZONE).                              
 RESTORE S(&PTFNAME.).                         
/*                                             
```