# How to join several Partitioned Data Sets PDSs into one Partitioned Data Set PDS?
Suppose you have 3 PDSs and you want to join them into one PDS.

Specify values for `#input_pds*` and `#output_pds`; change `SPACE` and `DCB` if needed.
```Haskell
//STEP1    EXEC PGM=IEBCOPY                                
//SYSPRINT DD   SYSOUT=*                                   
//IN1      DD   DSN=#input_pds1,DISP=SHR         
//IN2      DD   DSN=#input_pds2,DISP=SHR         
//IN3      DD   DSN=#input_pds3,DISP=SHR         
//*you can add more IN* here
//OUT      DD   DSN=#output_pds,DISP=(NEW,CATLG,DELETE),
//             DCB=*.IN1,SPACE=(CYL,(5,5,5))              
//SYSIN    DD   *                                          
  COPY OUTDD=OUT,INDD=(IN1,IN2,IN3)
/*                                                         
```