# Start DB2 Address space

```
//******************************************************//
//*  INSTRUCTIONS:                                     *//
//*  1. REPLACE ADDRESS_SPACE WITH YOUR ADDRESS SPACE  *//
//*     NAME.                                          *//
//*
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE BATCH
  /S ADDRESS_SPACE
```
