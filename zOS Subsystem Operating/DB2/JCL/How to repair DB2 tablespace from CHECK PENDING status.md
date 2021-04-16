# Repair DB2 Tablespace from CHKP status

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE DB2_SDSNLOAD WITH YOUR SDSNLOAD DS     *//
//*  2. REPLACE SUBSYSTEM_NAME WITH YOUR DB2 SUBSYSTEM *//
//*     NAME                                           *//
//*  3. REPLACE DATABASE_NAME WITH YOUR DATABASE NAME  *//
//*  4. REPLACE TABLESPACE_NAME WITH YOUR TABLESPACE   *//
//*
//REPAIR    EXEC DSNUPROC,SYSTEM=SUBSYSTEM_NAME,
//             LIB='DB2_SDSNLOAD',
//             UID=''
//SYSIN     DD  *
  REPAIR SET TABLESPACE DATABASE_NAME.TABLESPACE_NAME NOCHECKPEND
```
