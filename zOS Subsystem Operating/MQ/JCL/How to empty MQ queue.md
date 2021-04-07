# Empty MQ queue.

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE SUBSYSTEM_NAME WITH YOUR SUBSYSTEM NAME*//
//*  2. REPLACE MQ_SCSQANLE WITH YOUR SCSQANL[E]       *//
//*  3. REPLACE MQ_SCSQAUTH WITH YOUR SCSQAUTH         *//
//*  4. REPLACE MQ_QUEUE WITH YOUR QUEUE NAME          *//
//* 
//EMPTQUE   EXEC PGM=CSQUTIL,PARM='{SUBSYSTEM_NAME}'
//STEPLIB   DD   DISP=SHR,DSN={MQ_SCSQANLE}
//          DD   DISP=SHR,DSN={MQ_SCSQAUTH}
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  EMPTY QUEUE({MQ_QUEUE})
/*
```
