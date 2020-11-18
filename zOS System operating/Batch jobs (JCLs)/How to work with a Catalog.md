# How to work with a Catalog?

This document contains various operation for working with Catalogs

* [Create a User Catalog]()
* [Define an alias for a User Catalog]()
* [Delete an alias]()
* [Connect a User Catalog]()
* [Disconnect a User Catalog]()
* [Delete a User Catalog]()

# Сreate a User Catalog
Specify values for `#vol`,`#unit` and `#catalog_name`; change `CYLINDERS` if needed.
```
//STEP1    EXEC   PGM=IDCAMS
//VOL1     DD     VOL=SER=#vol,UNIT=#unit,DISP=OLD
//SYSPRINT DD     SYSOUT=*
//SYSIN    DD     *
  DEFINE USERCATALOG    -
   (NAME(#catalog_name) -
    CYLINDERS(5 1)      -
    VOLUME(#vol)        -
    ICFCATALOG          -
    SHAREOPTIONS(3 4))  -
    DATA                -
      (CONTROLINTERVALSIZE(4096)) -
    INDEX               -
      (CONTROLINTERVALSIZE(2048))
/*
```
# Define an alias for a User Catalog
Specify values for `#catalog_name`, `#alias` and `#mastercat_name`
```
//STEP1    EXEC PGM=IDCAMS                  
//SYSPRINT DD  SYSOUT=*                     
//SYSIN    DD  *                            
    DEFINE ALIAS(REL(#catalog_name) -
                 NAME(#alias))      -         
    CAT(#mastercat_name)                    
/*                                          
```

# Delete an alias
Specify values for `#alias` and `#mastercat_name`
```
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
     DEL (#alias) ALIAS -  
     CAT(#mastercat_name)
/*
```

# Connect a User Catalog
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

# Disconnect a User Catalog
Specify value for `#catalog_name`
```
//EXPORT   EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
   EXPORT #catalog_name  -  
     DISCONNECT
/*
```

# Delete a User Catalog
Specify valuse for `#cat_name`, `#cat_vol` and `#cat_unit`
```
//EX      EXPORT SYMLIST=(CATNAME,VOL,UNIT)    
//        SET    CATNAME=#cat_name             
//        SET    VOL=#cat_vol                  
//        SET    UNIT=#cat_unit                
//*                                            
//STEP1    EXEC PGM=IDCAMS                     
//VOL1     DD  VOL=SER=&VOL,UNIT=&UNIT,DISP=OLD
//SYSPRINT DD  SYSOUT=*                        
//SYSIN    DD  DATA,SYMBOLS=JCLONLY,DLM=$$     
  DELETE &CATNAME                -             
        FILE(VOL1)               -             
        USERCATALOG              -             
        FORCE                                  
  SET MAXCC = 0                                
$$                                             
```


