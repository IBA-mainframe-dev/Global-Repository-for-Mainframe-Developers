# Reorganize DB2 Tablespace with SCOPE PENDING

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE DB2_SDSNLOAD WITH YOUR SDSNLOAD DS     *//
//*  2. REPLACE SUBSYSTEM_NAME WITH YOUR DB2 SUBSYSTEM *//
//*     NAME                                           *//
//*  3. REPLACE DATABASE_NAME WITH YOUR DATABASE NAME  *//
//*  4. REPLACE TABLESPACE_NAME WITH YOUR TABLESPACE   *//
//*     NAME                                           *//
//*  5. REPLACE USER_SYSPUNCH WITH YOUR SYSPUNCH DS NAM*//
//*  6. REPLACE USER_SYSREC WITH YOUR SYSREC DS NAME   *//
//*  7. REPLACE USER_SYSUT1 WITH YOUR SYSUT1 DS NAME   *//
//*  8. REPLACE USER_SYSCOPY WITH YOUR SYSCOPY DS NAME *//
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
//SYSCOPY   DD DSN=USER_SYSCOPY,
//             DISP=(NEW,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SORTOUT   DD DSN=USER_SORTOUT,
//             DISP=(MOD,DELETE,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SYSIN     DD *
  REORG TABLESPACE DATABASE_NAME.TABLESPACE_NAME
  SCOPE PENDING 
```
