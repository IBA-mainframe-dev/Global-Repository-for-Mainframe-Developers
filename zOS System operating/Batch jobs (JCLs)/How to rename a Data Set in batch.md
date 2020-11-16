# How to rename a Data Set or a Data Set member?

# How to rename a Data Set in batch?
Specify values for `#old_name` and `#new_name`
```Haskell
//STEP1    EXEC PGM=IDCAMS                       
//SYSPRINT DD SYSOUT=*                           
//SYSIN    DD *                                  
  ALTER '#old_name'           NEWNAME('#new_name')
/*
```

# How to rename a Data Set member in batch?
Specify values for `#ds_name`, `#old_name` and `#new_name`
```Haskell
//STEP1    EXEC PGM=IDCAMS  
//SYSPRINT DD SYSOUT=*      
//SYSIN    DD *             
  ALTER -                   
  #ds_name(#old_name)      -
  NEWNAME(#ds_name(#new_name))
/*
 ```