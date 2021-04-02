## How to automate checking for normal completion of a job (counting the number of lines)?

* Suppose some z/OS program and/or Batch Job, upon normal completion, generates a strictly defined number of lines in the report
* If the completion is **NOT** normal, then the number of lines is always different.

**SOLUTION** - using the `IDCAMS PRINT` command. In my case, the correct number of records was 999. These lines were previously saved in the `INDSN01 DD` dataset.

The job will always return RC=00 if the number of records is 999. Any other number of records will end with RC=08
             
```
//*
//* EXAMPLE: check whether ?DATASET.TO.CHECK?
//*          has 999 records
//*
//PRINT01  EXEC PGM=IDCAMS                                  
//INDSN01  DD DISP=SHR,DSN=?DATASET.TO.CHECK?
//SYSPRINT DD SYSOUT=*                                      
//SYSIN    DD *                                             
  PRINT IFILE(INDSN01) SKIP(999) COUNT(1) CHAR              
                                                             
  IF LASTCC>0 THEN DO                                       
       SET LASTCC=0                                         
       SET MAXCC=0                                          
                                                             
       PRINT IFILE(INDSN01) SKIP(998) COUNT(1) CHAR         
       IF LASTCC>0 THEN DO                                  
       SET LASTCC=8                                         
       SET MAXCC=8                                          
    END                                                      
  END                                                       
  ELSE DO                                                   
    SET LASTCC=8                                            
    SET MAXCC=8                                              
  END                                                       
/*  
```
*Note:* if you check any other number of records (for instance, **N**), then instead of the values **999**, **998**, insert your values **N** and **N-1**, respectively.