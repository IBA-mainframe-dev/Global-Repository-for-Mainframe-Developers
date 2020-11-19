# How to split a Sequential Data Set or PDS member?

Suppose your data set is too large and you want to split it into parts.
For instance, this task split the dataset into 3 parts. The first thousand records will fall into data set `O1`, the second thousand records will fall into data set `O2`, and the all rest will fall into data set `O3`

*Note: you can change the number of records per part by specifying a different value in `SPLIT1R`*
## Split a Sequential Data Set
```
//  SET DSNAME=#ds_or_member_you_want_to_split                 
//STEP1  EXEC PGM=ICEMAN                          
//SYSOUT DD SYSOUT=*                              
//SORTIN DD DISP=OLD,DSN=&DSNAME                  
//O1     DD DISP=(NEW,CATLG,DELETE),DCB=*.SORTIN, 
//       SPACE=(CYL,(100,100),RLSE),              
//       DSN=&DSNAME..PART01                      
//O2     DD DISP=(NEW,CATLG,DELETE),DCB=*.SORTIN, 
//       SPACE=(CYL,(100,100),RLSE),              
//       DSN=&DSNAME..PART02                      
//O3     DD DISP=(NEW,CATLG,DELETE),DCB=*.SORTIN, 
//       SPACE=(CYL,(100,100),RLSE),              
//       DSN=&DSNAME..PART03                      
//*                                               
//* ADD MORE O'S IF NEEDED (APPEND THEM TO FNAMES)
//*                                               
//SYSIN  DD *                                     
  SORT   FIELDS=COPY                              
  OUTFIL FNAMES=(O1,O2,O3),SPLIT1R=1000              
/*                                                
```
## Split a PDS member
```
//  SET DSNAME=#input_pds
//  SET MEM=#member_you_want_to_split              
//STEP1  EXEC PGM=ICEMAN                          
//SYSOUT DD SYSOUT=*                              
//SORTIN DD DISP=OLD,DSN=&DSNAME(&MEM)                  
//O1     DD DISP=(NEW,CATLG,DELETE),DCB=*.SORTIN, 
//       SPACE=(CYL,(100,100),RLSE),              
//       DSN=&DSNAME..&MEM..PART01                      
//O2     DD DISP=(NEW,CATLG,DELETE),DCB=*.SORTIN, 
//       SPACE=(CYL,(100,100),RLSE),              
//       DSN=&DSNAME..&MEM..PART02                      
//O3     DD DISP=(NEW,CATLG,DELETE),DCB=*.SORTIN, 
//       SPACE=(CYL,(100,100),RLSE),              
//       DSN=&DSNAME..&MEM..PART03                      
//*                                               
//* ADD MORE O'S IF NEEDED (APPEND THEM TO FNAMES)
//*                                               
//SYSIN  DD *                                     
  SORT   FIELDS=COPY                              
  OUTFIL FNAMES=(O1,O2,O3),SPLIT1R=1000              
/*  
```
