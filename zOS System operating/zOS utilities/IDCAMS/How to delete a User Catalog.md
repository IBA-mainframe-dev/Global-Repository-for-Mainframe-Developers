# How to delete a User Catalog?
Specify valuse for `#cat_name`, `#cat_vol` and `#cat_unit`
```Haskell
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