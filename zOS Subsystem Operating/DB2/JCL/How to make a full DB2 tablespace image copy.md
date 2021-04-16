# Make a full DB2 Tablespace image copy

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
//*  6. REPLACE USER_GDG WITH YOUR GDG DS              *//
//*  7. REPLACE USER_SYSCOPY WITH YOUR SYSCOPY DS NAME *//
//*
//* DELETE THIS STEP IF YOU HAVE ALREADY CREATED GDG
//* GDG FOR FULL IMAGE COPY DATA SETS
//DEFGDG   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE GDG (NAME (USER_GDG) +
  LIMIT(2) SCRATCH)
/*
//COPY1     EXEC DSNUPROC,SYSTEM=SUBSYSTEM_NAME,
//             LIB='DB2_SDSNLOAD',
//             UID=''
//SYSCOPY   DD DSN=USER_SYSCOPY,
//             DISP=(NEW,CATLG),
//             SPACE=(TRK,(15,5),RLSE),
//             UNIT=SYSDA
//SYSIN     DD  *
  COPY TABLESPACE DATABASE_NAME.TABLESPACE_NAME DSNUM ALL
  FULL YES
```
