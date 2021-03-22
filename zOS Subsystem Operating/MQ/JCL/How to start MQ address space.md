# Start MQ address space.
Note: change variables in braces { } with yours without braces.
```
//SDSF      EXEC PGM=SDSF
//ISFOUT    DD SYSOUT=*
//CMDOUT    DD SYSOUT=*
//ISFIN     DD *
  SET CONSOLE BATCH
  /S {ADDRESS_SPACE}
```
