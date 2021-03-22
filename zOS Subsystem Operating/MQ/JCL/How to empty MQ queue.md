# Empty MQ queue.
Note: change variables in braces { } with yours without braces.
```
//EMPTQUE   EXEC PGM=CSQUTIL,PARM='{SUBSYSTEM_NAME}'
//STEPLIB   DD   DISP=SHR,DSN={MQ_SCSQANLE}
//          DD   DISP=SHR,DSN={MQ_SCSQAUTH}
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  EMPTY QUEUE({MQ_QUEUE})
/*
```
