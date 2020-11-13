# How to get list of members in a Partitioned Data Set in batch?
Specify values for `#ds_name`, `#unit` and `#vol`
```Haskell
//EX       EXPORT SYMLIST=(UNIT,VOL,DSNAME)   
//         SET UNIT=#unit                     
//         SET VOL=#vol                       
//         SET DSNAME=#ds_name                
//*                                           
//STEP1    EXEC PGM=IEHLIST                   
//SYSPRINT DD SYSOUT=*                        
//ALLOC1   DD UNIT=&UNIT,VOL=SER=&VOL,DISP=OLD
//SYSIN    DD DATA,SYMBOLS=JCLONLY,DLM=$$     
  LISTPDS DSNAME=&DSNAME,VOL=&UNIT=&VOL,FORMAT
$$                                                      
```