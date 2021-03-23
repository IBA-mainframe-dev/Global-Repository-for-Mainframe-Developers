# Start MQ channel.
Note: change variables in braces { } with yours without braces.
```
//START     EXEC PGM=CSQUTIL,PARM='{SUBSYSTEM_NAME}'
//STEPLIB   DD   DISP=SHR,DSN={MQ_SCSQANLE}
//          DD   DISP=SHR,DSN={MQ_SCSQAUTH}
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  COMMAND DDNAME(CMDINP)
/*
//CMDINP    DD *
  START CHANNEL({MQ_CHANNEL})
/*
```
