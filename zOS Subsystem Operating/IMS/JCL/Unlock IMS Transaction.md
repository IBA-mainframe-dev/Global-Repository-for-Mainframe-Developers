# How to Unlock IMS Transaction?

Unlock IMS Transaction through JCL.

Before run specify:
* ${USERID}
* ${JOB_ACCOUNTING_INFO}
* ${JOB_CLASS}
* ${IMS_PLEX}
* ${IMS_RESLIB}
* @{IMS_TRANSACTION}

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
//*   @{IMS_TRANSACTION}  
//*******************************************************************
//SPOC      EXEC PGM=CSLUSPOC,PARM=('IMSPLEX=${IMS_PLEX}')
//STEPLIB   DD DISP=SHR,DSN=${IMS_RESLIB}
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  UNLOCK TRAN @{IMS_TRANSACTION}
```