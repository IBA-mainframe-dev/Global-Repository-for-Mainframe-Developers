# This document contains useful day-to-day Omegamon for Db2 commands and scripts

## SDSF Omegamon for Db2 useful commands
| Description        | Command     |
|--------------------|:------------|
| Show PROCLIBs on the current LPAR| ```/$D PROCLIB ``` | 
| Start STC| ```/S XXXX01S ``` | 
| Stop STC| ```/P XXXX01S ``` | 
| To execute a command from one LPAR on the another one| ```/RO RS28,P XXXX02S ``` | 
| Change timeout for workloads| ```/F MODIFY SSIDIRLM,SET,TIMEOUT=180,SSID``` | 
| Stop instance| ```/F XXXX01S,F PESERVER,P SSID ``` |
| Start NTH (Near Term History) with the new attributes| ```/F XXXX01S,S H2WLMGR,OPTION=COPTSSID ``` | 

## Working with Batch Reporting useful JCL script
```
//P27021RP JOB (7949,SYS),'DB2PTF',CLASS=A,MSGCLASS=K, 
//                  MSGLEVEL=(1,1),REGION=0M,NOTIFY=&SYSUID 
//* 
//*           OMPE - REPORT GENERATION 
//* 
//DB2PMJB EXEC PGM=DB2PM
//* On MCEVS6 – OMPE V510 
//STEPLIB DD DISP=SHR,DSN=DB2TOOLS.OME510.VS6RTE.RKANMOD.D12012 
//*
//* !-------INPUTDSN
//* v
//INPUTDD DD DISP=SHR,DCB=BUFNO=50,
//           DSN=ONTOP.GS300.P27021.C624.SMF12234 //*
//SYSOUT DD SYSOUT=*
//JOBSUMDD DD SYSOUT=*, 
//             DCB=BLKSIZE=133
//MSGRPTDD
//             DCB=BLKSIZE=133
//SYSPRINT DD SYSOUT=*,
//             DCB=BLKSIZE=133 
//SYSIN DD * 
   GLOBAL      TIMEZONE (+7:00)
               FROM     (04/21/01,22:01:00.00) 
               TO       (04/21/01,23:01:00.00) 
               INCLUDE  (DB2ID(DSN7)) 
//* -Accounting Report Set-
//* Based on DB2 accounting records (IFCID 3, 239)
//* Contains local and distributed DB2 activity associated with a thread
//* Contains DBRM/package accounting information
 ACCOUNTING
     REPORT    LAYOUT   (LONG)
               ORDER    (CONNTYPE) 
               EXCLUDE  (PACKAGE(*))
     TRACE     TOP      (10 ONLY INAPPLET)
               LAYOUT   (LONG)    
     REPORT    LAYOUT(LONG)
               ORDER(PLANNAME)
//* -Statistics Report Set-
//* Based on DB2 Statistics records (IFCID 1,2, 225)
//* A prime indicator for subsystem-related problems
 STATISTICS
     REPORT    LAYOUT   (LONG) 
     TRACE     LAYOUT   (LONG) 
//*-System Parameters Report Set-
//* Show configuration information of subsystem (ZPARM's)
 SYSPARMS 
     TRACE
 EXEC
```
