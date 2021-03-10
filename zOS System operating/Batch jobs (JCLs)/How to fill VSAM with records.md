# Fill VSAM Data sets with record from `REPRO.DATA`

The job shows how to fill different types of VSAM Data sets with records

```
//FILLVSAM  EXEC PGM=IDCAMS                                             
//SYSPRINT DD SYSOUT=*                                                  
//KSDSOUT  DD DSN=USER.VSAM.KSDS,DISP=OLD                                
//ESDSOUT  DD DSN=USER.VSAM.ESDS,DISP=OLD                                
//INDD     DD DSN=REPRO.DATA(VSAM0000),DISP=SHR                  
//         DD DSN=REPRO.DATA(VSAM0100),DISP=SHR                  
//         DD DSN=REPRO.DATA(VSAM0200),DISP=SHR                  
//         DD DSN=REPRO.DATA(VSAM0300),DISP=SHR                  
//         DD DSN=REPRO.DATA(VSAM0400),DISP=SHR                               
//INDD00   DD DSN=REPRO.DATA(VSAM0000),DISP=SHR             
//SYSIN    DD *                                                    
 REPRO IFILE(INDD00) OFILE(ESDSOUT)                                
                                                                   
 REPRO IFILE(INDD) OFILE(KSDSOUT)                                  
                                                                   
 DEF ALTERNATEINDEX(NAME(USER.VSAM.KSDS.AIX) -                      
   RELATE(USER.VSAM.KSDS) -                                         
     VOL(VOL101) TRK(1,1) SHR(1 3) -                               
      KEYS(5 11))                                                  

 BLDINDEX INDATASET(USER.VSAM.KSDS) -                                 
        OUTDATASET(USER.VSAM.KSDS.AIX)                                
                                                                     
 DEFINE PATH (NAME(USER.VSAM.KSDS.PATH) -                             
             PATHENTRY(USER.VSAM.KSDS.AIX))                           
/*                                                                   
```

## Related topics

* [Create a VSAM Data set]()
* [Delete a Data set]()