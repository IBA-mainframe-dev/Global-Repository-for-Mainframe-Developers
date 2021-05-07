# JCL job to load PTF information into global zone and SMP/e datasets

**`RECVPTF` - This JCL job is used to load PTF information into `GLOBAL ZONE` and SMP/E datasets**

[**Link to clone/download from the repository**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20loading%20PTF%20information%20into%20global%20zone%20and%20SMPe%20datasets/RECVPTF)

```
//RECVPTF    JOB <JOB PARAMETERS>    
//*----------------------------------------------------    
//*  THIS JOB IS USED TO LOAD PTF INFORMATION
//*  INTO GLOBAL ZONE AND SMP/E DATASETS 
//*
//*  INSTRUCTIONS:
//*  CHANGE SMPEHLQ TO THE HLQ YOU NEED
//*  CHANGE PTFNAME WITH YOUR PTF NAME
//*  CHANGE PTFHLQ TO THE PTF HLQ YOU NEED
//*----------------------------------------------------
//EX EXPORT SYMLIST=(SMPEHLQ,PTFNAME,PTFHLQ)  
// SET SMPEHLQ=#SMPE HLQ#
// SET PTFNAME=#PTF NAME HERE#
// SET PTFHLQ=#PTF HLQ HERE#
//*                         
//*---------------------------------------------------------------------
//*  THIS JOB RECEIVES PTF INTO GLOBAL ZONE                             
//*---------------------------------------------------------------------
//RECVPTF  EXEC PGM=GIMSMP,COND=(0,NE),REGION=0M                        
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
//SMPOUT   DD SYSOUT=*                                       
//SMPRPT   DD SYSOUT=*                                       
//SMPLIST  DD SYSOUT=*                                       
//SYSPRINT DD SYSOUT=*                                       
//SUBST    DD SYSOUT=*                                       
//SMPPTFIN DD DSN=&PTFHLQ..&PTFNAME.,DISP=SHR                
//SMPCNTL  DD  *,SYMBOLS=(JCLONLY,SUBST)                     
 SET BDY (GLOBAL).                                           
 RECEIVE SYSMODS SELECT(&PTFNAME.) .                         
/*                      
```