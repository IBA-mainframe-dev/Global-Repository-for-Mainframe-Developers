# How do I automate the submission of a job at regular intervals?

1. Create the `SUBJOB` member in your PROCLIB library (for instance, `SYS1.PROCLIB`)

*Note:* You can call it any name you like. We will need this name in the next steps.

2. Write the following JCL into it:
```
//SUBJOB  PROC CLASS='A',                   <- default input job class
//             LIST='*',                    <- default SYSPRINT class
//             LIB='USER01.JCLLIB',         <- default JCL library name
//             MEM=SMFCLEAR                 <- default member name
//*
//IEFPROC  EXEC PGM=IEBEDIT
//SYSPRINT DD   SYSOUT=&LIST
//SYSUT1   DD   DDNAME=IEFRDER
//SYSUT2   DD   SYSOUT=(&CLASS,INTRDR),DCB=BLKSIZE=80
//SYSIN    DD   DUMMY
//IEFRDER  DD   DISP=SHR,DSN=&LIB.(&MEM.)
```
The SUBJOB procedure will read the library name and the member name given and pass the content of that library member to the jcl internal reader. Thus, the job can be submitted for execution.

3. Now let's prepare a command to submit the job from a library.
```
S SUBJOB,LIB=#jcl_lib,MEM=#lib_member
```
*Note*: 
  * `SUBJOB` is the proclib member name we specified in the first step
  * `#jcl_lib` is the name of the JCL library
  * `#lib_member` is the name of the library member where the job is placed
  * The parameters can be omitted if we are going to submit the job that was set by default

4. Now we can use the automatic JES commands to schedule job submitting. For instance, submit a job every 20 seconds.
```
/$T A,I=20,'$VS,''S SUBJOB,LIB=''#jcl_lib'',MEM=#lib_member'' '
```

### How to use the automatic JES commands

When you code this command, JES2 establishes a starting point `T(hhh.mm)` (when to begin issuing a command), and an interval `I(sssss)` (when to repeat a command).

| Description       | Command          |
|-------------------|:-----------------|
|Display automatic commands you are authorized to see|`/$T A,ALL`|
|Issue `$jes-command` every 90 seconds|`/$T A,I=90,'$jes-command'`|
|Issue `$d u` every 24 hours from starting point 12:30 AM|`/$T A,T=00.30,I=86400,'$d u'`|
|Issue MVS command `SEND 'message-text'` every 20 seconds|`/$T A,I=20,'$VS,''SEND ''message-text'''''`|
|Cancel all automatic commands|`/$C A,ALL`|
|Cancel automatic command with ID = 2|`/$C A2`|

For more information on the automatic JES commands - [IBM documentation](https://www.ibm.com/docs/en/zos/2.3.0?topic=section-t-display-specify-modify-automatic-commands)