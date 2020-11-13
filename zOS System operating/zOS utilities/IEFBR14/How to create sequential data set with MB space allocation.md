Create sequential data set with following parameters:
- Record length: 80 bytes
- Record format: Fixed Blocked.
- Space: 2MB of primary allocation and 1MB of secondary allocation

```
//JCLLIB10 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)          
//STEP1    EXEC PGM=IEFBR14                           
//ALLOC    DD DSN=STV.ALLOC.TASK10,DISP=(NEW,CATLG),  
//         RECFM=FB,LRECL=80,BLKSIZE=27920,           
//         AVGREC=M,SPACE=(1,(2,1))                   
```
