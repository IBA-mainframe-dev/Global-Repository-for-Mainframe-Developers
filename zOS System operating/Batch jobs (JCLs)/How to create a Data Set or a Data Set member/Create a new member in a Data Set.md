# How do I create a new member in a Data Set?

If you leave new member file without modifying it, it won't be saved.
This why you can't just use `PGM=IEFBR14` with `DSN=USER.LIBRARY(MEMBER),DISP=SHR`. It will not be saved because it wasn't modified in any way.
You need to use **IEBGENER**. You want to create data set without writing any data into it so you can use empty in-stream DD statement `'//SYSUT1 DD *'`. In such case end-of-file mark is written to member but it is enough to create it.

```
//JCLLIB05 JOB NOTIFY=&SYSUID,MSGLEVEL=(1,1)       
//COPYMEM  EXEC PGM=IEBGENER                       
//SYSPRINT DD SYSOUT=*                             
//SYSIN    DD DUMMY                                
//SYSUT1   DD *                                    
//SYSUT2   DD DSN=[Data set name]([Member name]),DISP=SHR
```
