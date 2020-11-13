# How to rename a Data Set in batch?
Specify values for `#old_name` and `#new_name`
```Haskell
//STEP1    EXEC PGM=IDCAMS                       
//SYSPRINT DD SYSOUT=*                           
//SYSIN    DD *                                  
  ALTER '#old_name'           NEWNAME('#new_name')
/*
```