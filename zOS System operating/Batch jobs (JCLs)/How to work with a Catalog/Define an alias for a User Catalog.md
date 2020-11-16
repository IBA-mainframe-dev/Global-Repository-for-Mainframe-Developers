# How to define an alias for a User Catalog?
Specify values for `#catalog_name`, `#alias` and `#mastercat_name`
```Haskell
//STEP1    EXEC PGM=IDCAMS                  
//SYSPRINT DD  SYSOUT=*                     
//SYSIN    DD  *                            
    DEFINE ALIAS(REL(#catalog_name) -
                 NAME(#alias))      -         
    CAT(#mastercat_name)                    
/*                                          
```