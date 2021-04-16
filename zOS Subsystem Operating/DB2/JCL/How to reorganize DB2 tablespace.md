# Reorganize DB2 Tablespace

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
//*  6. REPLACE USER_SYSPUNCH WITH YOUR SYSPUNCH DS NAM*//
//*  7. REPLACE USER_SYSREC WITH YOUR SYSREC DS NAME   *//
//*  8. REPLACE USER_SYSUT1 WITH YOUR SYSUT1 DS NAME   *//
//*  9. REPLACE USER_SORTOUT WITH YOUR SORTOUT DS NAME *//
//*
//REORG1    EXEC DSNUPROC,SYSTEM=SUBSYSTEM_NAME,
//             LIB='DB2_SDSNLOAD',
//             UID=''
//SYSPUNCH  DD DSN=USER_SYSPUNCH,
//             DISP=(MOD,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SYSREC    DD DSN=USER_SYSREC,
//             DISP=(MOD,CATLG),
//             SPACE=(TRK,(15,5),RLSE),
//             UNIT=SYSDA
//SYSUT1    DD DSN=USER_SYSUT1,
//             DISP=(MOD,DELETE,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SORTOUT   DD DSN=USER_SORTOUT,
//             DISP=(MOD,DELETE,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SYSIN     DD *
  REORG TABLESPACE DATABASE_NAME.TABLESPACE_NAME
   LOG YES
   SORTDATA
   SORTDEVT SYSDA
   SORTNUM 4
```
