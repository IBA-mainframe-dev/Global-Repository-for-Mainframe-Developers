# How to list all possible information about Partitioned Data Set PDS?
Specify values for `#ds_name`, `#unit` and `#vol`
```Haskell
//EXP      EXPORT SYMLIST=(DSNAME,UNIT,VOL)              
//*                                            
//         SET DSNAME=#ds_name
//         SET UNIT=#unit
//         SET VOL=#vol
//*                                            
//STEP1    EXEC PGM=IEHLIST                              
//SYSPRINT DD SYSOUT=*                                   
//ALLOC1   DD DISP=OLD,UNIT=&UNIT,VOL=SER=&VOL           
//SYSIN    DD DATA,SYMBOLS=JCLONLY,DLM=$$                
  LISTVTOC FORMAT,PDSESPACE,VOL=&UNIT=&VOL,DSNAME=&DSNAME
  LISTVTOC DUMP,VOL=&UNIT=&VOL,DSNAME=&DSNAME            
  LISTPDS  FORMAT,VOL=&UNIT=&VOL,DSNAME=&DSNAME          
  LISTPDS  DUMP,VOL=&UNIT=&VOL,DSNAME=&DSNAME            
$$                                                       
```