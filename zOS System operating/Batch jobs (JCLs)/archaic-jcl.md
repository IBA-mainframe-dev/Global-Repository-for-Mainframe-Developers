
* [DD Statements](#dd-statements)
* [Replace COND with IF](#replace-cond-with-if)
* [Use INCLUDE Statements to Simplify JCL](#use-include-statements-to-simplify-jcl)


## DD statements

Old JCL may contain archaic but still supported constructs, such as...

    //OUTPUT01 DD  DISP=(NEW,CATLG,DELETE),
    //             UNIT=SYSDA,
    //             DSN=IBMUSER.OUTPUT01,
    //             DCB=(LRECL=80,BLKSIZE=27920,RECFM=FB),
    //             SPACE=(27920,(10,10),RLSE)
    
The above, with System Managed Storage (SMS) active and System Determined Blocksize in effect, may be rewritten as...

    //OUTPUT01 DD  DISP=(NEW,CATLG,DELETE),
    //             DSN=&SYSUID..OUTPUT01,
    //             AVGREC=U,
    //             LRECL=80,
    //             RECFM=FB,
    //             SPACE=(80,(3500,3500),RLSE)
    
...where the hardcoded userID is replaced with a system symbol, the hardcoded block size has been eliminated, the generic `UNIT` has been eliminated in favor of what the Storage Administrator coded for the default `STORCLAS`, and the `LRECL` and `RECFM` have been freed from the enclosing `DCB=()` construct which is no longer required.

## Replace COND with IF

Old JCL may have job steps that are conditionally executed...

    //BACKUP01 EXEC PGM=IDCAMS
    .
    .
    .
    //BACKUP02 EXEC PGM=IDCAMS
    .
    .
    .
    //PREPARE  EXEC PGM=PREPUPDT
    .
    .
    .
    //UPDATE01 EXEC PGM=FINUPDT0,COND=((4,GT,BACKUP01),(0,NE,BACKUP02),(4,GT,PREPUPDT))

...which, while understood by JES, has always been somewhat difficult for humans to comprehend.  The `COND=` construct above may be replaced by the equivalent and more easily understandable...

    //BACKUP01 EXEC PGM=IDCAMS
    .
    .
    .
    //BACKUP02 EXEC PGM=IDCAMS
    .
    .
    .
    //PREPARE  EXEC PGM=PREPUPDT
    .
    .
    .
    //IF01     IF BACKUP01.RC <= 4 & BACKUP02.RC = 0 & PREPUPDT.RC <= 4 THEN
    //UPDATE01 EXEC PGM=FINUPDT0
    //IF01E    ENDIF

...which version would you rather try to understand in a hurry?

## Use INCLUDE Statements to Simplify JCL

`INCLUDE` statements can be used to simplify and standardize JCL by inserting prewritten blocks of JCL at job submission time.  These blocks of JCL might be standard STEPLIB concatenations or the ubiquitous SYSOUT DD statements.  So instead of...

    //UPDATE01 EXEC PGM=FINUPDT0
    //STEPLIB  DD  DISP=SHR,DSN=PROD.FINANCE.LOADLIB
    //         DD  DISP=SHR,DSN=PROD.DB2.LOADLIB
    //         DD  DISP=SHR,DSN=PROD.UTILITY.LOADLIB
    //INPUT01  DD  DISP=OLD,DSN=PROD.FINANCE.UPDATE(0)
    //SYSOUT   DD  SYSOUT=&MSGCLAS
    //SYSPRINT DD  SYSOUT=&MSGCLAS
    //SYSUDUMP DD  SYSOUT=&DMPCLAS
    //CEEDUMP  DD  SYSOUT=&DMPCLAS

...you can code...

    //UPDATE01 EXEC PGM=FINUPDT0
    //STEPLIB  INCLUDE MEMBER=PRODSTEP
    //INPUT01  DD  DISP=OLD,DSN=PROD.FINANCE.UPDATE(0)
    //MAINFILE DD  DISP=OLD,DSN=PROD.FINANCE.MAIN
    //SYSOUT   INCLUDE MEMBER=SYSOUT

...where the PRODSTEP and SYSOUT members in one of the libraries in your `JCLLIB ORDER=` concatenation contain the original JCL statements.  Thus, if the STEPLIB concatenation ever needs to change or an additional SYSOUT DD becomes necessary, it can be done in one place instead of in every job step or proc step.

Our friends in the OO world might call this refactoring.
