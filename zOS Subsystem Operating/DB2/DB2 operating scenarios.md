# **This document contains various DB2 work scenarios**

## How to see data in DBRM in printable format (not in Unicode)

You need to open DBRM via ```BROWSE``` (not via ```View```) and issue in command line:
```
DISPLAY ASCII 
```
If you need to see them back in Unicode - close and reopen them or issue:
```
DISPLAY EBCDIC
```


## DB2 table recovery

**Below is a strict sequence of steps to recover table in DB2**

**1. Job example**

```
//USER01   JOB ,                                        
//             'DB2ADM',MSGLEVEL=(1,1),NOTIFY=&SYSUID   
//STEP2 EXEC PGM=DSN1PRNT,                              
// PARM='PRINT(2),FORMAT,FULLCOPY'                      
//*STEPLIB DD DSN=DB2A.SDSNLOAD,DISP=SHR                
//SYSUDUMP DD SYSOUT=A                                  
//SYSPRINT DD SYSOUT=A                                  
//SYSUT1 DD DSN=USER01.DSN8.IC.TEST.TESTTS,DISP=SHR   <-- name of the backup file
/*         
```

**2. Find the PGSOBD field value in the printout. For example: PGSOBD = '0003'X <- this is the table internal id**

**3. Job example**

```
//USER01   JOB ,                                        
//             'DB2ADM',MSGLEVEL=(1,1),NOTIFY=&SYSUID   
//STEP2 EXEC PGM=DSN1PRNT,                              
// PARM='PRINT(0),FORMAT,FULLCOPY'                      
//*STEPLIB DD DSN=DB2A.SDSNLOAD,DISP=SHR                
//SYSUDUMP DD SYSOUT=A                                  
//SYSPRINT DD SYSOUT=A                                  
//SYSUT1 DD DSN=USER01.DSN8.IC.TEST.TESTTS,DISP=SHR   <-- name of the backup file
/*     
```

**4. Find the HPGOBID field value in the printout. For example: PGSOBD = '014D0005'X. This means, that the internal database ID was '014D'X (= 333) and the internal tablespace ID was '0005'X (= 5)**

**5. Stop tablespace**

**6. Execute SQL query**

```
SELECT DBID, PSID FROM SYSIBM.SYSTABLESPACE   
                       WHERE NAME='tablespace name'
                         AND DBNAME='database name';
```
For example:  DBID=274, PSID=2

**7. Execute SQL query**

```
SELECT NAME, OBID FROM SYSIBM.SYSTABLES        
                       WHERE TSNAME='tablespace name'   
                         AND CREATOR=' SQL_ID name under which the object was created ';
```
For example:  OBID =6

**8. Restore a tablespace from a backup by requesting a conversion of the table's internal id**
 
 ```
 //USER01   JOB ,                                             
 //             'DB2ADM',MSGLEVEL=(1,1),NOTIFY=&SYSUID        
 //EXECUTE EXEC PGM=DSN1COPY,PARM='RESET,FULLCOPY,OBIDXLAT'   
 //*STEPLIB DD DSN=PDS                                        
 //SYSPRINT DD SYSOUT=A                                       
 //SYSUT1 DD DSN=USER01.DSN8.IC.TEST.TESTTS,   <-- name of the backup file               
 // DISP=OLD                                                  
 //SYSUT2 DD DSN=DSN8.DSNDBD.TEST.TESTTS.I0001.A001,    <-- VSAM dataset name       
 // DISP=OLD                                                  
 //SYSXLAT DD *                                               
 333,274        <-- internal database id                                                  
 5,2            <-- internal tablespace identifier                                                          
 3,6            <-- internal table id                                                          
  /*          
```

**9. Start tablespace**


## DB2 cold start

**To cold start a Db2 subsystem in a data sharing environment:**

1. Stop all other members of the data sharing group.
2. Cold start the chosen member using ACCESS(MAINT). The cold start deallocates the group buffer pools to which this member was connected.
3. Resolve all data inconsistency problems resulting from the cold start.
4. Start all the other members and restart this one without ACCESS(MAINT).