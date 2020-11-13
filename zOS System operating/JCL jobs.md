# This document contains JCL jobs for frequent tasks.

## Allocating Data Sets

Note: type your values insted of information in brackets [] without brackets.

### 1. Create sequential data set with following parameters:
- Record length: 80 bytes
- Record format: Fixed
- Space: 2 track for both primary and secondary allocation

```
//JCLLIB01 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//STEP1    EXEC PGM=IEFBR14                                   
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),        
//         RECFM=F,BLKSIZE=80,LRECL=80,SPACE=(TRK,(2,2))
```

### 2. Create sequential data set with following parameters:
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

### 3. Create PDS with following parameters:
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

### 4. Create PDS/E with following parameters:
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

### 5. Create new member in data set.

If you leave new member file without modifying it, it won't be saved.
This why you can't just use PGM=IEFBR14 with DSN=USER.LIBRARY(MEMBER),DISP=SHR. It will not be saved because it wasn't modified in any way.
You need to use IEBGENER. You want to create data set without writing any data into it so you can use empty in-stream DD statement '//SYSUT1 DD *'. In such case end-of-file mark is written to member but it is enough to create it.

```
//JCLLIB05 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)       
//COPYMEM  EXEC PGM=IEBGENER                       
//SYSPRINT DD SYSOUT=*                             
//SYSIN    DD DUMMY                                
//SYSUT1   DD *                                    
//SYSUT2   DD DSN=[Data set name]([Member name]),DISP=SHR
```

### 6. Copy member to new Sequential data set.

Note: It is good practice to use Referback (Backward Reference) in DCB parameter. You will ensure data set compatibility this way.

```
//JCLLIB06 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)         
//COPYMEM  EXEC PGM=IEBGENER                         
//SYSPRINT DD SYSOUT=*                               
//SYSIN    DD DUMMY                                  
//SYSUT1   DD DSN=[Data set name]([Member name]),DISP=SHR    
//SYSUT2   DD DSN=[Data set name],DISP=(NEW,CATLG),  
//         DCB=*.SYSUT1,SPACE=(TRK,(1,1))            
```

### 7. Copy sequential data set into member of newly created PDS.

```
//JCLLIB07 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//COPYMEM  EXEC PGM=IEBGENER                                  
//SYSPRINT DD SYSOUT=*                                        
//SYSIN    DD DUMMY                                           
//SYSUT1   DD DSN=[Data set name],DISP=SHR                    
//SYSUT2   DD DSN=[Data set name]([Member name]),DISP=(NEW,CATLG),     
//         DCB=*.SYSUT1,SPACE=(TRK,(1,1,5))                   
```

### 8. Create sequential data set with following parameters:
- Record length available to use: 400 bytes
- Record format: Variable
- Space: 1 track for both primary and secondary allocation

```
//JCLLIB08 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                
//STEP1    EXEC PGM=IEFBR14                                 
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),         
//         SPACE=(TRK,(1,1)),RECFM=V,BLKSIZE=256,LRECL=512  
```

### 9. Create sequential data set with following parameters:
- Record length available to use: 400 bytes
- Record format: Variable Blocked where one block should contain 10 records.
- Space: 1 track for both primary and secondary allocation

```
//JCLLIB09 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//STEP1    EXEC PGM=IEFBR14                                   
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),           
//         SPACE=(TRK,(1,1)),RECFM=VB,BLKSIZE=5124,LRECL=512   
```

### 10. Create sequential data set with following parameters:
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

### 11. Allocate PS-L Data Set.

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