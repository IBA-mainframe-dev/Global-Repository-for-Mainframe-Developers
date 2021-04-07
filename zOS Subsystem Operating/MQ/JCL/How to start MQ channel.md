# Start MQ channel.

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE SUBSYSTEM_NAME WITH YOUR SUBSYSTEM NAME*//
//*  2. REPLACE MQ_SCSQANLE WITH YOUR SCSQANL[E]       *//
//*  3. REPLACE MQ_SCSQAUTH WITH YOUR SCSQAUTH         *//
//*  4. REPLACE MQ_CHANNEL WITH YOUR CHANNEL NAME      *//
//* 
//START     EXEC PGM=CSQUTIL,PARM='SUBSYSTEM_NAME'
//STEPLIB   DD   DISP=SHR,DSN=MQ_SCSQANLE
//          DD   DISP=SHR,DSN=MQ_SCSQAUTH
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  COMMAND DDNAME(CMDINP)
/*
//CMDINP    DD *
  START CHANNEL(MQ_CHANNEL)
/*
```
