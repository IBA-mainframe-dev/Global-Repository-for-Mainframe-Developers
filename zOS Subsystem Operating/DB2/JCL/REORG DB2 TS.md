# Reorganize DB2 Tablespace

```
//${USERID}1 JOB (${JOB_ACCOUNTING_INFO}),'REORG DB2 TS',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//REORG1    EXEC DSNUPROC,SYSTEM=${SUBSYSTEM_NAME},
//             LIB='${DB2_SDSNLOAD}',
//             UID=''
//SYSPUNCH  DD DSN=DSNB10.${SUBSYSTEM_NAME}.CNTL.@{DB2_TS_2}.@{DB2_TS_3},
//             DISP=(MOD,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SYSREC    DD DSN=DSNB10.${SUBSYSTEM_NAME}.UNLD.@{DB2_TS_2}.@{DB2_TS_3},
//             DISP=(MOD,CATLG),
//             SPACE=(TRK,(15,5),RLSE),
//             UNIT=SYSDA
//SYSUT1    DD DSN=@{DB2_TS_1}.SYSUT1,
//             DISP=(MOD,DELETE,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SORTOUT   DD DSN=@{DB2_TS_1}.SORTOUT,
//             DISP=(MOD,DELETE,CATLG),
//             SPACE=(TRK,(5,5),RLSE),
//             UNIT=SYSDA
//SYSIN     DD *
  REORG TABLESPACE @{DB2_TS_2}.@{DB2_TS_3}
   LOG YES
   SORTDATA
   SORTDEVT SYSDA
   SORTNUM 4
```
