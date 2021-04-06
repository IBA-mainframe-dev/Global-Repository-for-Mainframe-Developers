# How to Start IMS Adress space?

Start IMS adress space through JCL.

Before run specify:
* ${USERID}
* ${JOB_ACCOUNTING_INFO}
* ${JOB_CLASS}
* @{ADDRESS_SPACE}

```
//${USERID}D JOB (${JOB_ACCOUNTING_INFO}),'STA ADDR SPACE',REGION=2M,
//        MSGCLASS=H,CLASS=${JOB_CLASS}
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE BATCH
  /S @{ADDRESS_SPACE}
```