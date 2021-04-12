# Start DB2 Indexspace with RW access

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE DB2_SDSNLOAD WITH YOUR SDSNLOAD DS     *//
//*  2. REPLACE SUBSYSTEM_NAME WITH YOUR DB2 SUBSYSTEM *//
//*     NAME                                           *//
//*  3. REPLACE DATABASE_NAME WITH YOUR DATABASE NAME  *//
//*  4. REPLACE INDEXSPACE_NAME WITH YOUR INDEXSPACE   *//
//*     NAME                                           *//
//*
//START1    EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSTSPRT  DD SYSOUT=*
//STEPLIB   DD DSN=DB2_SDSNLOAD,DISP=SHR
//SYSPRINT  DD SYSOUT=*
//SYSUDUMP  DD SYSOUT=*
//SYSOUT    DD SYSOUT=*
//SYSTSIN   DD *
  DSN SYSTEM(SUBSYSTEM_NAME)
  -STA DB(DATABASE_NAME) SPACENAM(INDEXSPACE_NAME) ACCESS(RW)
  END
//SYSIN     DD DUMMY
```
