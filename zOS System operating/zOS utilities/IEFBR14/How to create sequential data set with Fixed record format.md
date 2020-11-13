Create sequential data set with following parameters:
- Record length: 80 bytes
- Record format: Fixed
- Space: 2 track for both primary and secondary allocation

```
//JCLLIB01 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//STEP1    EXEC PGM=IEFBR14                                   
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),        
//         RECFM=F,BLKSIZE=80,LRECL=80,SPACE=(TRK,(2,2))
