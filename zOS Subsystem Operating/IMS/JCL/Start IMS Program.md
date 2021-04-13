# How to start IMS Program?

Start IMS Program through JCL.

Before run specify:
* ${USERID}
* ${JOB_ACCOUNTING_INFO}
* ${JOB_CLASS}
* ${IMS_PLEX}
* ${IMS_RESLIB}
* @{IMS_PROGRAM}

```
//${USERID}S JOB (${JOB_ACCOUNTING_INFO}),'EXECUTE IMS CMD',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//*******************************************************************
//*   Before run specify:
//*   ${USERID}
//*   ${JOB_ACCOUNTING_INFO}
//*   ${JOB_CLASS}
//*   ${IMS_PLEX}
//*   ${IMS_RESLIB}
//*   @{IMS_PROGRAM}  
//*******************************************************************
//SPOC      EXEC PGM=CSLUSPOC,PARM=('IMSPLEX=${IMS_PLEX}')
//STEPLIB   DD DISP=SHR,DSN=${IMS_RESLIB}
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  STA PGM @{IMS_PROGRAM}
```