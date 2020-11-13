# How to list contents of VTOC on `#vol` volume?
Specify value for `#vol`
```Haskell
//EX       EXPORT SYMLIST=(VOLID)              
//         SET VOLID=#vol                      
//STEP1    EXEC PGM=IEHLIST                    
//SYSPRINT DD SYSOUT=*                         
//ALLOC1   DD DISP=OLD,UNIT=3390,VOL=SER=&VOLID
//SYSIN    DD DATA,SYMBOLS=JCLONLY,DLM=$$      
 LISTVTOC FORMAT,VOL=3390=&VOLID               
$$                                             
```