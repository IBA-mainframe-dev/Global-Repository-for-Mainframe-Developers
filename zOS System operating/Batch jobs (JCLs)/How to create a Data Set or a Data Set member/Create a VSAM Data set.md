# Create a VSAM Data set

## Creating a KSDS VSAM Data set

Specify `#ds_name` and `#volume`; change parameters if needed
```                                                                    
//DEFVSAM  EXEC PGM=IDCAMS                                             
//SYSPRINT DD SYSOUT=*                                                 
//SYSIN    DD *                                                        
 DEF CLUSTER(NAME(#ds_name)             -                      
     VOL(#volume) TRK(1,1) SHR(1 3))    -                          
   DATA(NAME(#ds_name.DATA)             -                         
     CISZ(4096) KEYS(10 0) RECORDSIZE(80 80)) -                        
   INDEX(NAME(#ds_name.INDEX)           -                         
     CISZ(2048))                                                       
/*
```

## Creating a ESDS VSAM Data set

Specify `#ds_name` and `#volume`; change parameters if needed
```
//DEFVSAM  EXEC PGM=IDCAMS                                             
//SYSPRINT DD SYSOUT=*                                                 
//SYSIN    DD *   
 DEF CLUSTER(NAME(#ds_name)             -                       
    VOLUMES(#volume) CYLINDERS(1 1)     -                   
    NONINDEXED)                         -                            
  DATA(NAME(#ds_name.DATA)              -                           
    CISZ(4096) RECORDSIZE(354 354))                                
/*
```

## Creating a RRDS VSAM Data set

Specify `#ds_name` and `#volume`; change parameters if needed
```
//DEFVSAM  EXEC PGM=IDCAMS                                             
//SYSPRINT DD SYSOUT=*                                                 
//SYSIN    DD *   
 DEF CLUSTER(NAME(#ds_name)             -                          
    VOLUMES(#volume)  CYLINDERS(1 1)    -                   
    RECORDSIZE(354 354)                 -                        
    NUMBERED)                                                      
/*
```

## Related topics

* [Delete a Data set]()
* [Fill a VSAM Data set with records]()
