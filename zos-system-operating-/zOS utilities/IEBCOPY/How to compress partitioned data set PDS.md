# How to compress a Partitioned Data Set PDS?
Specify value for `#input_pds`
```Haskell
//STEP1    EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*
//SYSUT1   DD   DSN='input_pds',DISP=SHR
//SYSIN    DD *
  COPY OUTDD=SYSUT1,INDD=SYSUT1
```