Create sequential data set with following parameters:
- Record length available to use: 400 bytes
- Record format: Variable Blocked where one block should contain 10 records.
- Space: 1 track for both primary and secondary allocation

```
//JCLLIB09 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//STEP1    EXEC PGM=IEFBR14                                   
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),           
//         SPACE=(TRK,(1,1)),RECFM=VB,BLKSIZE=5124,LRECL=512   
```
