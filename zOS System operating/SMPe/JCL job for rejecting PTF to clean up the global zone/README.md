# JCL job for rejecting PTF to clean up the global zone

**`REJCTPTF` - This JCL job is used to reject PTF to clean up the `GLOBAL ZONE`**

[**Link to clone/download from the repository**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20rejecting%20PTF%20to%20clean%20up%20the%20global%20zone/REJCTPTF)

```
//REJCTPTF   JOB <JOB PARAMETERS>    
//*----------------------------------------------------    
//*  THIS JOB IS USED TO REJECT PTF TO CLEAN UP    
//*  THE GLOBAL ZONE
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
//*  THIS JOB REJECTS PTF FROM GLOBAL ZONE                              
//*---------------------------------------------------------------------
//REJPTF   EXEC PGM=GIMSMP,COND=(0,NE),REGION=0M                        
//SMPLOG   DD SYSOUT=*                                                  
//SMPLOGA  DD SYSOUT=*                                                  
//SMPCSI   DD DSN=&SMPEHLQ..GB.CSI,DISP=SHR                             
//SMPPTS   DD DSN=&SMPEHLQ..SMPPTS,DISP=SHR                             
//SYSUT1   DD &SPACE3                                                   
//SMPOUT   DD SYSOUT=*                                                  
//SMPRPT   DD SYSOUT=*                                                  
//SYSPRINT DD SYSOUT=*                                                  
//SMPCNTL  DD  *,SYMBOLS=(JCLONLY,SUBST)                                
 SET BDY (GLOBAL).                                                      
 REJECT  S(&PTFNAME.) BYPASS(APPLYCHECK) .                              
/*                          
```