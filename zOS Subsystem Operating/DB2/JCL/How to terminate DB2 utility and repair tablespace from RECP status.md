# Terminate DB2 Utility. Repair DB2 Tablespace from RECP status

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
//TERM1     EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSTSPRT  DD SYSOUT=*
//STEPLIB   DD DSN=DB2_SDSNLOAD,DISP=SHR
//SYSPRINT  DD SYSOUT=*
//SYSUDUMP  DD SYSOUT=*
//SYSOUT    DD SYSOUT=*
//SYSTSIN   DD *
  DSN SYSTEM(SUBSYSTEM_NAME)
  -TERM UTILITY (UTID)
  END
//SYSIN     DD DUMMY
//RECOVER   EXEC DSNUPROC,SYSTEM=SUBSYSTEM_NAME,
//             LIB='DB2_SDSNLOAD',
//             UID=''
//SYSIN     DD  *
  REPAIR SET TABLESPACE DATABASE_NAME.TABLESPACE_NAME NORCVRPEND
```
