# How to create a Sequential Data Set in batch.md
	
* [Create a Sequential Data Set with Fixed record format](#create-a-sequential-data-set-with-fixed-record-format)
* [Create a Sequential Data Set with Variable (V) record format](#create-a-sequential-data-set-with-variable-(v)-record-format)
* [Create a Sequential Data Set with Fixed Blocked (FB) record format](#create-a-sequential-data-set-with-fixed-blocked-(fb)-record-format)
* [Create a Sequential Data Set with Variable Blocked (VB) record format](#create-a-sequential-data-set-with-variable-blocked-(vb)-record-format)
* [Create a Sequential Data Set with MB space allocation](#create-a-sequential-data-set-with-mb-space-allocation)

## Create a Sequential Data Set with Fixed record format

Create a Sequential Data Set with following parameters:
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

## Create a Sequential Data Set with Variable (V) record format

Create a Sequential Data Set with following parameters:
- Record length available to use: 400 bytes
- Record format: Variable
- Space: 1 track for both primary and secondary allocation

```
//JCLLIB08 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                
//STEP1    EXEC PGM=IEFBR14                                 
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),         
//         SPACE=(TRK,(1,1)),RECFM=V,BLKSIZE=256,LRECL=512  
```

## Create a Sequential Data Set with Fixed Blocked (FB) record format

Create a Sequential Data Set with following parameters:
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

## Create a Sequential Data Set with Variable Blocked (VB) record format

Create a Sequential Data Set with following parameters:
- Record length available to use: 400 bytes
- Record format: Variable Blocked where one block should contain 10 records.
- Space: 1 track for both primary and secondary allocation

```
//JCLLIB09 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)                  
//STEP1    EXEC PGM=IEFBR14                                   
//ALLOC    DD DSN=[Data set name],DISP=(NEW,CATLG),           
//         SPACE=(TRK,(1,1)),RECFM=VB,BLKSIZE=5124,LRECL=512   
```

## Create a Sequential Data Set with MB space allocation

Create a Sequential Data Set with following parameters:
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