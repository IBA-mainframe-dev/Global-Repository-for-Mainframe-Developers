# How to Open extrapartition TDQ?

Open extrapartition TDQ through JCL.

Before run specify:
* ${USERID}
* ${JOB_CLASS}
* ${CICS_CONSOLE}
* ${SUBSYSTEM_NAME}
* @{CICS_TDQ}

```
//${USERID}C JOB (),'SET EXT TDQ OPEN',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//***********************************************
//*   Before run specify:
//*   ${USERID}
//*   ${JOB_CLASS}
//*   ${CICS_CONSOLE}
//*   ${SUBSYSTEM_NAME}
//*   @{CICS_TDQ} 
//***********************************************
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE ${CICS_CONSOLE}
  /F ${SUBSYSTEM_NAME},CEMT SET TDQ(@{CICS_TDQ}) OPEN
  PRINT FILE CMDOUT
  ULOG
  PRINT
  PRINT CLOSE
 /*
```