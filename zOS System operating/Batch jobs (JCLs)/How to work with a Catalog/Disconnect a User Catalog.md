# How to disconnect a User Catalog?
Specify value for `#catalog_name`
```
//EXPORT   EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
   EXPORT #catalog_name  -  
     DISCONNECT
/*
```