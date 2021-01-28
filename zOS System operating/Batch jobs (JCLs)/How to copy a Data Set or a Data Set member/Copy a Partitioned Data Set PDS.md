# How to copy a Partitioned Data Set PDS?
### To a new PDS
Specify values for `#input_pds`,`#output_pds`, `#unit` and `#volume`; change `SPACE` and `DCB` if needed;
```
//STEP1    EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*                          
//SYSIN    DD   DUMMY                             
//SYSUT1   DD   DSN=#input_pds,DISP=SHR
//SYSUT2   DD   DSN=#output_pds,DISP=(NEW,CATLG),
//           DCB=(LRECL=80,RECFM=FB,BLKSIZE=6160),
//           SPACE=(CYL,(5,5,5)),
//           UNIT=#unit,
//           VOL=SER=#volume
```
*Note: the original `#input_pdse` dataset will not be removed.*
### To an already existing PDS without members replacement
Specify values for `#input_pds`,`#output_pds`.
```
//STEP1    EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*                          
//SYSUT1   DD   DSN=#input_pds,DISP=SHR
//SYSUT2   DD   DSN=#output_pds,DISP=OLD
//SYSIN    DD   *
  COPY INDD=SYSUT1,OUTDD=SYSUT2
/*
```
*Note: the original `#input_pdse` dataset will not be removed.*
### To an already existing PDS with members replacement
Specify values for `#input_pds`,`#output_pds`.
```
//STEP1    EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*                          
//SYSUT1   DD   DSN=#input_pds,DISP=SHR
//SYSUT2   DD   DSN=#output_pds,DISP=OLD
//SYSIN    DD   *
  COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2,LIST=YES
/*
```
*Note: the original `#input_pdse` dataset will not be removed.*