# How to pack or unpack a dataset with TERSE

Tersed (packed) datasets are usually used to send/receive z/OS sequential or partitioned datasets across network. 
Tersed datasets need to be uploaded as binary files in the following format:
* LRECL: 1024
* RECFM: FB
* BLOCKSIZE: 1024

## Terse (pack) a PDS

Packing  a PDS is exactly the same as packing a “normal” sequential dataset so we will show  only JCL used to pack a PDS.
```
//TERSEPDS JOB (,),REGION=0M,NOTIFY=&SYSUID,CLASS=A
//*-------------------------------------------------                                               
//DEL      EXEC PGM=IEFBR14                       
//D1       DD DSN=IBMUSER.DATA.PDS.TERSED,          
//            UNIT=SYSDA,SPACE=(TRK,1),           
//            DISP=(MOD,DELETE)                   
//*                                               
//TERSE    EXEC PGM=TRSMAIN,PARM=PACK             
//SYSPRINT DD SYSOUT=*                            
//INFILE   DD DISP=SHR,DSN=IBMUSER.DATA.PDS,           
//OUTFILE  DD DISP=(NEW,CATLG),UNIT=SYSDA,        
//            SPACE=(TRK,(10,10),RLSE),           
//            DSN=IBMUSER.DATA.PDS.TERSED           
//*           DCB=(DSORG=PS,RECFM=FB,LRECL=1024)
```

## Unterse (unpack) a PDS

To unpack a PDS is, as with packing, very similar to unpacking a sequential dataset. The only difference is that you need to be careful to allocate a PDS for the output and specify a directory size on the space parameter:
```
//UNTERPDS JOB (,),REGION=0M,NOTIFY=&SYSUID,CLASS=A
//*-----------------------------------------------------------
//UNTERPDS EXEC PGM=TRSMAIN,PARM=UNPACK                                 
//SYSPRINT DD SYSOUT=*                                                  
//INFILE   DD DSN=IBMUSER.DATA.PDS.TERSED,
//            DISP=SHR                      
//OUTFILE  DD DSN=IBMUSER.DATA.PDS.UNTERSED,                            
//            DISP=(NEW,CATLG),                                         
//            SPACE=(CYL,(1,1,1))
```
The only difference with the unpack job for sequential dataset is the extra parameter to allocate directory block on last line of shown JCL
