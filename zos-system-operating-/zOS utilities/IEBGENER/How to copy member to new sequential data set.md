Note: It is good practice to use Referback (Backward Reference) in DCB parameter. You will ensure data set compatibility this way.

```
//JCLLIB06 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)         
//COPYMEM  EXEC PGM=IEBGENER                         
//SYSPRINT DD SYSOUT=*                               
//SYSIN    DD DUMMY                                  
//SYSUT1   DD DSN=[Data set name]([Member name]),DISP=SHR    
//SYSUT2   DD DSN=[Data set name],DISP=(NEW,CATLG),  
//         DCB=*.SYSUT1,SPACE=(TRK,(1,1))            
```
