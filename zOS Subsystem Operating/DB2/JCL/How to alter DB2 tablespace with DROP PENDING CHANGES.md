# Alter DB2 Tablespace with DROP PENDING CHANGES
```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE DB2_SDSNLOAD WITH YOUR SDSNLOAD DS     *//
//*  2. REPLACE SUBSYSTEM_NAME WITH YOUR DB2 SUBSYSTEM *//
//*     NAME                                           *//
//*  3. REPLACE DB2_RUNLIB_LOAD WITH YOUR DB2 RUNLIB   *//
//*  4. REPLACE DATABASE_NAME WITH YOUR DATABASE NAME  *//
//*  5. REPLACE TABLESPACE_NAME WITH YOUR TABLESPACE   *//
//*     NAME                                           *//
//*
//ALTER1   EXEC PGM=IKJEFT01
//STEPLIB   DD  DSN=DB2_SDSNLOAD,
//             DISP=SHR
//SYSTSIN   DD  *
  DSN SYSTEM(SUBSYSTEM_NAME)
  RUN PROGRAM(DSNTEP2) PLAN(DSNTEP11)  -
  LIB('DB2_RUNLIB_LOAD')
  END
//*
//SYSIN     DD  *
  ALTER TABLESPACE DATABASE_NAME.TABLESPACE_NAME DROP PENDING CHANGES;
/*
//SYSTSPRT  DD  SYSOUT=*
//SYSPRINT  DD  SYSOUT=*
```
