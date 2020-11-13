PS-L or Physical Sequential Large Data Set.
Standard PS also called Basic PS data set can have maximum 65 535 tracks per volume and can use 59 volumes. In total maximum size of Basic PS is:
59 * 65535 * 55996 = 201.64 GB

PS-L can have 16 777 215 tracks per volume:
59 * 16777215 * 55996 = 51.41 TB

Of course those are approximate calculations, in reality it depends on many data set characteristics for example record format or block size.

Both PS and PS-L can have the same amount of extends. If you need more than 16 extends per volume you must allocate PS-E - Physical Sequential Extended Data Set.

```
//JCLLIB11 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                
//STEP1    EXEC PGM=IEFBR14                                 
//ALLOC    DD DSN=STV.ALLOC.TASK11,DISP=(NEW,CATLG),        
//         SPACE=(TRK,1),RECFM=FB,BLKSIZE=27920,LRECL=80,   
//         DSNTYPE=LARGE                                    
```
