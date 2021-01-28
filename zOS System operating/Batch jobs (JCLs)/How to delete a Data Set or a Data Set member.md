# How to delete a Data Set or a Data Set member?

## How to delete a Data Set in batch?
Specify value for `#ds_name`
```
//STEP1    EXEC PGM=IDCAMS           
//SYSPRINT DD SYSOUT=*               
//SYSOUT   DD SYSOUT=*               
//SYSIN    DD *                      
   DELETE #ds_name              PURGE
/*        
```

## How to delete a Data Set member in batch?
Specify values for `#input_pds` and` #member`
```
//STEP1    EXEC PGM=IDCAMS                      
//SYSPRINT DD SYSOUT=*                          
//SYSOUT   DD SYSOUT=*                          
//DD1      DD DSN=#input_pds         ,DISP=SHR  
//SYSIN    DD *                                 
   DELETE #input_pds(#member)         FILE(DD1)
/*                                              
```

## How to delete Data Sets using mask?
Specify value for `#ds_with_mask`
```
//STEP1    EXEC PGM=IDCAMS         
//SYSPRINT DD   SYSOUT=*           
//SYSIN    DD   *                  
  DELETE #ds_with_mask MASK NONVSAM
  SET MAXCC = 0                    
/*                                                                              
```
