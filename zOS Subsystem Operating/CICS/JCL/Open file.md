# How to Open CICS file?

Open file through JCL.

Before run specify:
* ${USERID}
* ${JOB_CLASS}
* ${CICS_CONSOLE}
* ${SUBSYSTEM_NAME}
* @{CICS_FILE}

```
//${USERID}C JOB (),'SET FILE OPEN',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//***********************************************
//*   Before run specify:
//*   ${USERID}
//*   ${JOB_CLASS}
//*   ${CICS_CONSOLE}
//*   ${SUBSYSTEM_NAME}
//*   @{CICS_FILE}
//***********************************************
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE ${CICS_CONSOLE}
  /F ${SUBSYSTEM_NAME},CEMT SET FILE(@{CICS_FILE}) OPEN
  PRINT FILE CMDOUT
  ULOG
  PRINT
  PRINT CLOSE
 /*
```