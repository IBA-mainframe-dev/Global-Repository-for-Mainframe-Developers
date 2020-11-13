# How to copy selected members from partitioned data set PDS?  
Specify values for `#input_pds`,`#output_pds` and member names.
### With SELECT operator
Copy selected members
```Haskell
//STEP1    EXEC PGM=IEBCOPY                                             
//SYSPRINT DD   SYSOUT=*                                                
//SYSUT1   DD   DSN=#input_pds,DISP=SHR                      
//SYSUT2   DD   DSN=#output_pds,DISP=OLD                      
//SYSIN    DD *                                                         
 COPY OUTDD=SYSUT2,INDD=SYSUT1                                          
    SELECT MEMBER=(#mem_name1,#mem_name2,                              -
     #mem_name3)
/*                                                                      
```
*Note: be careful with the line continuation operator `-`*
### With EXCLUDE operator
Copy everything except these members
```Haskell
//STEP1    EXEC PGM=IEBCOPY                                             
//SYSPRINT DD   SYSOUT=*                                                
//SYSUT1   DD   DSN=#input_pds,DISP=SHR                      
//SYSUT2   DD   DSN=#output_pds,DISP=OLD                      
//SYSIN    DD *                                                         
 COPY OUTDD=SYSUT2,INDD=SYSUT1                                          
    EXCLUDE MEMBER=(#mem_name1,#mem_name2)           
/*
```
*Note: be careful with the line continuation operator `-`*