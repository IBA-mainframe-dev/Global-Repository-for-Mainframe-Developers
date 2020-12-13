//SAMPLE   JOB <JOB PARAMETERS>    
//*----------------------------------------------------    
//*  THIS JOB IS USED TO PREPARE AND PACKING DATASETS FOR 
//*  TRANSFERRING AND SENDING THEM TO A REMOTE SYSTEM
//*
//*  INSTRUCTIONS:
//*
//*  CHANGE THE FOLLOWING VALUES:
//*  SAMPHLQ - PROVIDE YOUR HIGH-LEVEL QUALIFIER
//*  REMSERV - PROVIDE YOUR REMOTE SERVER 
//*  IP-ADDRESS (EXAMPLE: 172.10.10.100)
//*  PWD - PROVIDE YOUR REMOTE SERVER PASSWORD
//*  DATASET(INCLUDE(#DATASETS LIST, REQUIRED  
//*  FOR TRANSFERRING#))
//*  NODE NAME TO TRANSFER
//*  
//*----------------------------------------------------
//EX EXPORT SYMLIST=(SAMPHLQ,REMSERV,PWD)                       
// SET SAMPHLQ=#HLQ#                                               
// SET REMSERV=#REMOTE_SERVER_IP#                                            
// SET PWD=#REMOTE_SERVER_PASSWORD#                                                     
//*                                                                     
//*---------------------------------------------------------------------
//*  DELETE DATASETS                                                    
//*---------------------------------------------------------------------
//DELETE   EXEC PGM=IEFBR14                                             
//SYSPRINT DD SYSOUT=*                                                  
//SYSOUT   DD SYSOUT=*                                                  
//SYSUDUMP DD SYSOUT=*                                                  
//FILE1    DD DSN=&SAMPHLQ..DUMP,                                       
//             UNIT=SYSDA,DISP=(MOD,DELETE,DELETE),SPACE=(CYL,(0))      
//FILE2    DD DSN=&SAMPHLQ..XMIT,                                       
//             UNIT=SYSDA,DISP=(MOD,DELETE,DELETE),SPACE=(CYL,(0))      
//FILE3    DD DSN=&SAMPHLQ..GETRC,                                      
//             UNIT=SYSDA,DISP=(MOD,DELETE,DELETE),SPACE=(CYL,(0))      
//*---------------------------------------------------------------------
//*  DUMP DATASETS INTO ONE FILE                                        
//*---------------------------------------------------------------------
//STEP1   EXEC PGM=ADRDSSU,REGION=0M                                    
//SYSPRINT DD SYSOUT=*                                                  
//OUT1     DD DSN=&SAMPHLQ..DUMP,DISP=(,CATLG,DELETE),                  
//  UNIT=SYSDA,SPACE=(CYL,(300,60),RLSE)                                
//SYSIN    DD *,SYMBOLS=(JCLONLY,SUBST)                                 
   DUMP DATASET(INCLUDE(
          #DATASET 1 REQUIRED FOR TRANSFERRING#  
          #DATASET 2 REQUIRED FOR TRANSFERRING#
        )) -               
          SHARE   -                                                     
          OUTDDNAME(OUT1)                                               
/*                                                                      
//*---------------------------------------------------------------------
//* XMIT FILE FROM STEP1 TO GET IT IN FB FORMAT                         
//*---------------------------------------------------------------------
//STEP2   EXEC PGM=IKJEFT01                                             
//SYSTSPRT   DD SYSOUT=*                                                
//SYSOUT     DD SYSOUT=*                                                
//SYSTSIN    DD *,SYMBOLS=(JCLONLY,SUBST)                               
 XMIT #NODE NAME HERE#.&SYSUID DSN('&SAMPHLQ..DUMP') -                              
 OUTDSN('&SAMPHLQ..XMIT')                                               
/*                                                                      
//*---------------------------------------------------------------------
//* FTP FILES FROM STEP2 AND RECEIVE IT, RESTORE REMOTELY               
//*---------------------------------------------------------------------
//STEP3 EXEC PGM=FTP,PARM='(EXIT',COND=(0,NE)                           
//SYSMDUMP   DD   SYSOUT=                                               
//SYSPRINT   DD   SYSOUT=*                                             
//INPUT DD *,SYMBOLS=(JCLONLY,SUBST)                                   
&REMSERV.                                                              
&SYSUID                                                                   
&PWD.                                                                  
BINARY                                                                 
PUT '&SAMPHLQ..XMIT' '&SAMPHLQ..XMIT'                                  
ASCII                                                                  
PUT '&SAMPHLQ..JCL(RECVLIBS)' 'RECVLIBS'                               
QUOTE SITE FILETYPE=JES                                                
QUOTE SITE JESOWNER=*                                                  
QUOTE SITE JESJOBNAME=*                                                
GET 'RECVLIBS' '&SAMPHLQ..GETRC'                                       
QUOTE SITE FILETYPE=SEQ                                                
DELETE 'RECVLIBS'                                                      
CLOSE                                                                  
QUIT                                                                   
/*                                                                     
//*------------------------------------------------------------------- 
//* CHECK RC FROM REMOTE JOB RUN                                       
//*------------------------------------------------------------------- 
//RUNSCRP1  EXEC PGM=IKJEFT01,DYNAMNBR=30,REGION=0M,                   
//          PARM='CHECKRC &SAMPHLQ..GETRC'                             
//SYSEXEC   DD   DSN=&SAMPHLQ..EXEC,DISP=SHR                           
//SYSTSPRT  DD   SYSOUT=*                                              
//SYSTSIN   DD   DUMMY                                                 
//*--------------------------------------------------------------------
//DELETE   EXEC PGM=IEFBR14                                            
//SYSPRINT DD SYSOUT=*                                                 
//SYSOUT   DD SYSOUT=*                                                 
//SYSUDUMP DD SYSOUT=*                                                 
//DELE1    DD DSN=&SAMPHLQ..GETRC,                                     
//             UNIT=SYSDA,DISP=(MOD,DELETE,DELETE),SPACE=(CYL,(0))     