# How to connect a User Catalog?
Specify values for `#vol`and `#catalog_name`
```
//STEP1     EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*    
//SYSIN     DD *           
 IMPORT CONNECT           -
   OBJECTS                -
     ((#catalog_name      -
        DEVICETYPE(3390)  -
        VOLUMES(#vol)     -
     ))                    
/*                         
```