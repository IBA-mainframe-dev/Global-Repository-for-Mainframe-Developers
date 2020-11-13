Create sequential data set with following parameters:
- Record length available to use: 400 bytes
- Record format: Variable
- Space: 1 track for both primary and secondary allocation

```
//JCLLIB08 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                
//STEP1    EXEC PGM=IEFBR14                                 
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),         
//         SPACE=(TRK,(1,1)),RECFM=V,BLKSIZE=256,LRECL=512  
```
