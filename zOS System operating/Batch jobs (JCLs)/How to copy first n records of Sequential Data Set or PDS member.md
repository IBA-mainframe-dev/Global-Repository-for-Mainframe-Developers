# How to copy first `n` records of Sequential Data Set or PDS member?
Specify values for `n`, `#input_ds` and `#output_ds`
```
//STEP1    EXEC PGM=IDCAMS,REGION=5M              
//SYSPRINT DD   SYSOUT=*                          
//IN       DD   DSN=#input_ds,DISP=SHR
//OUT      DD   DSN=#output_ds,DISP=SHR    
//SYSIN    DD   *                                 
  REPRO IFILE(IN) OFILE(OUT) COUNT(n)    
/*
```