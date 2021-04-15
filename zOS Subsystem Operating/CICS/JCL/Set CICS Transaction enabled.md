# How to Set CICS Transaction enabled?

Set CICS Transaction enabled through JCL.

Before run specify:
* ${USERID}
* ${JOB_ACCOUNTING_INFO}
* ${JOB_CLASS}
* ${CICS_CONSOLE}
* ${SUBSYSTEM_NAME}
* @{CICS_TRANSACTION}

```
//${USERID}C JOB (${JOB_ACCOUNTING_INFO}),'SET TRAN ENABLED',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//************************************************************************
//*   Before run specify:
//*   ${USERID}
//*   ${JOB_ACCOUNTING_INFO}
//*   ${JOB_CLASS}
//*   ${CICS_CONSOLE}
//*   ${SUBSYSTEM_NAME}
//*   @{CICS_TRANSACTION}
//************************************************************************
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE ${CICS_CONSOLE}
  /F ${SUBSYSTEM_NAME},CEMT SET TRANSACTION(@{CICS_TRANSACTION}) ENABLED
  PRINT FILE CMDOUT
  ULOG
  PRINT
  PRINT CLOSE
/*
```