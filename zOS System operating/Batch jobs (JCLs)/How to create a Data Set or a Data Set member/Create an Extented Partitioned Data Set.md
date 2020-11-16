# How to create an Extented Partitioned Data Set?

Create PDS/E with following parameters:
- Record length: 80
- Record format: Fixed Blocked
- Optimal Block Size
- Space: 1 cylinder for both primary and secondary allocation

```
//JCLLIB04 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                         
//STEP1    EXEC PGM=IEFBR14                                          
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),DSNTYPE=LIBRARY,  
//         RECFM=FB,LRECL=80,BLKSIZE=27920,SPACE=(CYL,(1,1,5)) 
```