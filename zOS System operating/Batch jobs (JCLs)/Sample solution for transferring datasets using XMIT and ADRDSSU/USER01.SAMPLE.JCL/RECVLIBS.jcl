//RECVLIBS JOB <JOB PARAMETERS>         
//*----------------------------------------------------    
//*  THIS JOB IS USED TO RECEIVE DATASETS ON A REMOTE SYSTEM
//*  AND UNPACKING THEM
//*
//*  INSTRUCTIONS:
//*
//*  CHANGE THE FOLLOWING VALUES:
//*  SAMPHLQ - PROVIDE YOUR HIGH-LEVEL QUALIFIER
//*  OUTDYNAM(#REMOTE_SYSTEM_VOLUME#) -
//*  SPECIFY THE NAME OF THE REMOTE SYSTEM_VOLUME
//*  RENAMEUNCONDITIONAL(*.**,#NEW_PREFIX#.**) - REPLACE  
//*  NEW_PREFIX WITH CURRENT PREFIX ON LPAR
//*  ON ANOTHER SYSTEM WHEN UNPACKING (FOR EXAMPLE: 
//*  RENAMEUNCONDITIONAL(*.**,&NEWHLQ..**))
//*
//*----------------------------------------------------
//EX EXPORT SYMLIST=(SAMPHLQ)                              
// SET SAMPHLQ=#HLQ#                                  
//*----------------------------------------------------    
//*  RECEIVE XMITTED DATASET                               
//*----------------------------------------------------    
//STEP1   EXEC PGM=IKJEFT01                                
//FROMFILE   DD DSN=&SAMPHLQ..XMIT,DISP=SHR                
//SYSTSPRT   DD SYSOUT=*                                   
//SYSPRINT   DD SYSOUT=*                                   
//SYSTSIN    DD *,SYMBOLS=(JCLONLY,SUBST)                  
 RECEIVE INDDNAME(FROMFILE)                                
 DATASET('&SAMPHLQ..DUMP')                                 
/*                                                         
//*-----------------------------------------               
//* UNPACK DUMP FILE                                       
//*-----------------------------------------
//STEP2   EXEC PGM=ADRDSSU,REGION=0M                       
//SYSPRINT DD SYSOUT=*                                     
//RESTDD   DD DSN=&SAMPHLQ..DUMP,DISP=SHR,                 
//  UNIT=SYSDA                                             
//SYSIN    DD *,SYMBOLS=(JCLONLY,SUBST)                    
 RESTORE DATASET(INCLUDE(*.**)) -                                      
      INDDNAME(RESTDD) -                                               
      OUTDYNAM(#REMOTE_SYSTEM_VOLUME#) -                                               
      RENAMEUNCONDITIONAL(*.**,#NEW_PREFIX#.**) -                                 
      REPLACEUNCONDITIONAL -                                           
      CATALOG -                                                        
      SHARE                                                            
/*                                                                     
//*--------------------------------------------------------------------
//* DELETE DATASETS                                                    
//*--------------------------------------------------------------------
//DELETE   EXEC PGM=IEFBR14                                            
//SYSPRINT DD SYSOUT=*                                                 
//SYSOUT   DD SYSOUT=*                                                 
//SYSUDUMP DD SYSOUT=*                                                 
//FILE1    DD DSN=&SAMPHLQ..DUMP,                                      
//             UNIT=SYSDA,DISP=(MOD,DELETE,DELETE),SPACE=(CYL,(0))     
//FILE2    DD DSN=&SAMPHLQ..XMIT,                                      
//             UNIT=SYSDA,DISP=(MOD,DELETE,DELETE),SPACE=(CYL,(0))     