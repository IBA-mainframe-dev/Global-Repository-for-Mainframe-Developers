Create PDS with following parameters:
- Record length: 80
- Record format: Fixed Blocked
- Optimal Block Size
- Space: 2 cylinder for both primary and secondary allocation
- Directory blocks: 10

```
//JCLLIB03 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                   
//STEP1    EXEC PGM=IEFBR14                                    
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),            
//         RECFM=FB,LRECL=80,BLKSIZE=27920,SPACE=(CYL,(2,2,10))
```
