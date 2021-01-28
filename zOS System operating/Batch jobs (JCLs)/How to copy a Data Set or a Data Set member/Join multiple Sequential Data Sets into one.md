# How to join multiple Sequential Data Sets into one?

Specify values for `#input_ds*` and `#output_ds`; change `SPACE` and `DCB` if needed.

```
//STEP1  EXEC PGM=IEBGENER
//SYSUT1 DD DISP=SHR,DSN=#input_ds1
//       DD DISP=SHR,DSN=#input_ds2
//       DD DISP=SHR,DSN=#input_ds3
//*
//* append more datasets if needed 
//*
//SYSUT2 DD DISP=(NEW,CATLG,DELETE),
//          SPACE=(CYL,(500,500),RLSE),
//          DCB=*.SYSUT1,
//          DSN=#output_ds
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSIN DD DUMMY
```
