# How to start IMS MPR Region?

Start IMS MPR Region through JCL.

Before run specify:
* ${USERID}
* ${JOB_ACCOUNTING_INFO}
* ${JOB_CLASS}
* ${IMS_PLEX}
* ${IMS_RESLIB}
* @{IMS_MPR}

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
//*   @{IMS_MPR}  
//*******************************************************************
//SPOC      EXEC PGM=CSLUSPOC,PARM=('IMSPLEX=${IMS_PLEX}')
//STEPLIB   DD DISP=SHR,DSN=${IMS_RESLIB}
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  STA REG @{IMS_MPR}
```