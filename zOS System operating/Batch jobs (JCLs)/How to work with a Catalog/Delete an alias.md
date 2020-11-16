# How to delete an alias?
Specify values for `#alias` and `#mastercat_name`
```
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
     DEL (#alias) ALIAS -  
     CAT(#mastercat_name)
/*
```