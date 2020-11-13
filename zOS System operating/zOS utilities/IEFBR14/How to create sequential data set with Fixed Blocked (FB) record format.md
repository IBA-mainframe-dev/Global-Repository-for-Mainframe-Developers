Create sequential data set with following parameters:
- Record length: 80 bytes
- Record format: Fixed Blocked
- Block size: 27920
- Space: 1 cylinder for primary extend and no secondary allocation

```
//JCLLIB02 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//STEP1    EXEC PGM=IEFBR14                                   
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),        
//         RECFM=FB,LRECL=80,BLKSIZE=27920,SPACE=(CYL,(1))
```