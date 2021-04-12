#  Terminate DB2 Utility. Start DB2 Tablespace with RW access. Repair DB2 Tablespace from RECP status

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE DB2_SDSNLOAD WITH YOUR SDSNLOAD DS     *//
//*  2. REPLACE SUBSYSTEM_NAME WITH YOUR DB2 SUBSYSTEM *//
//*     NAME                                           *//
//*  3. REPLACE UTID WITH YOUR DB2 UTILITY ID          *//
//*  4. REPLACE DATABASE_NAME WITH YOUR DATABASE NAME  *//
//*  5. REPLACE TABLESPACE_NAME WITH YOUR TABLESPACE   *//
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
  -TERM UTIL (UTID)
  -STA DB(DATABASE_NAME) SPACENAM(TABLESPACE_NAME) ACCESS(RW)
  END
//SYSIN     DD DUMMY
//REPAIR    EXEC DSNUPROC,SYSTEM=SUBSYSTEM_NAME,
//             LIB='DB2_SDSNLOAD',
//             UID=''
//SYSIN     DD  *
  REPAIR SET TABLESPACE DATABASE_NAME.TABLESPACE_NAME NORECVPEND  
```
