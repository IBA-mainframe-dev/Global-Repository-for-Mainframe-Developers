# How to Set CICS Program enabled?

Set CICS Program enabled through JCL.

Before run specify:
* ${USERID}
* ${JOB_ACCOUNTING_INFO}
* ${JOB_CLASS}
* ${CICS_CONSOLE}
* ${SUBSYSTEM_NAME}
* @{CICS_PROGRAM}

```
//${USERID}C JOB (${JOB_ACCOUNTING_INFO}),'SET PROGRAM ENABLED',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//************************************************************************
//*   Before run specify:
//*   ${USERID}
//*   ${JOB_ACCOUNTING_INFO}
//*   ${JOB_CLASS}
//*   ${CICS_CONSOLE}
//*   ${SUBSYSTEM_NAME}
//*   @{CICS_PROGRAM}
//************************************************************************
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE ${CICS_CONSOLE}
  /F ${SUBSYSTEM_NAME},CEMT SET PROG(@{CICS_PROGRAM}) ENABLED
  PRINT FILE CMDOUT
  ULOG
  PRINT
  PRINT CLOSE
 /*
```