# How to convert Partitioned Data Set PDS to Partitioned Data Set Extended PDSE and vice versa?
### PDS to PDSE
Specify values for `#input_pds` and `#output_pdse`; change `SPACE` if needed;
```
//STEP1    EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*                          
//SYSIN    DD   DUMMY                             
//SYSUT1   DD   DSN=#input_pds,DISP=SHR
//SYSUT2   DD   DSN=#output_pdse,DISP=(NEW,CATLG),
//           DCB=*.SYSUT1,SPACE=(CYL,(5,5,5)),DSNTYPE=LIBRARY
```
*Note: the original `#input_pds` dataset will not be removed.*
### PDSE to PDS
Specify values for `#input_pdse` and `#output_pds`; change `SPACE` if needed;
```
//STEP1    EXEC PGM=IEBCOPY
//SYSPRINT DD   SYSOUT=*                          
//SYSIN    DD   DUMMY                             
//SYSUT1   DD   DSN=#input_pdse,DISP=SHR
//SYSUT2   DD   DSN=#output_pds,DISP=(NEW,CATLG),
//           DCB=*.SYSUT1,SPACE=(CYL,(5,5,5)),DSNTYPE=PDS
```
*Note: the original `#input_pdse` dataset will not be removed.*