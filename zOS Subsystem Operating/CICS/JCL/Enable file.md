# How to Enable CICS file?

Enable file through JCL.

Before run specify:
* ${USERID}
* ${JOB_CLASS}
* ${CICS_CONSOLE}
* ${SUBSYSTEM_NAME}
* @{CICS_FILE}

```
//${USERID}C JOB (),'SET FILE ENABLED',REGION=2M,
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
  /F ${SUBSYSTEM_NAME},CEMT SET FILE(@{CICS_FILE}) ENABLE
  PRINT FILE CMDOUT
  ULOG
  PRINT
  PRINT CLOSE
 /*
```