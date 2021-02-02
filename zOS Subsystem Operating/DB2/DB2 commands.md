# This document contains various day-to-day DB2 commands.

## Display commands

| Command | Description | 
|---------|:------------|
|Display all accelerator servers, whether the servers are currently in use or no  |```-DIS ACCEL(*)``` |
|Display input archive log information |```-DIS ARCHIVE```|
|Display the current buffer pool status for all active or inactive buffer pools |```-DIS BPOOL(*)``` |
|Display information on all databases that are defined to the Db2 subsystem for which the privilege set of the process has the required authorization  |```-DIS DATABASE(*)``` |
|Display information regarding the status and configuration of DDF, additional statistics and configuration information  |```-DIS DDF DETAIL``` |
|Display information about threads and conversations with specific remote   |```-DIS LOCATION(LOC1,LOC2,LOC3)``` |
|Display detailed information about conversations with all remote locations, and detail conversation information about Db2 system threads that communicate with other locations   |```-DIS LOCATION DETAIL``` |
|Display log information about, and the status of, the offload task   |```-DIS LOG``` |
|Display the status of active and inactive profiling activities  |```-DIS PROFILE``` |
|Display the current status of the resource limit facility   |```-DIS RLIM``` |
|Display current status information about DB2 threads.|```-DIS THD``` |
|Display currect trace activity|```-DIS TRACE(*)``` |
|Display the status and UTILIDs of all utility jobs.|```-DIS UTIL(*)``` |
|Display the status of utility job with UTILID=UTILID.|```-DIS UTIL(UTULID)``` |

## Start commands

| Command | Description | 
|---------|:------------|
|Start DB2|```-START DB2(DB2SSID)``` |
|Start all databases for which you have authority|```-START DATABASE(*)```|
|Start table space TSNAME in database DBNAME|```-START DATABASE (DBNAME) SPACENAM (TSNAME)```|
|Start the third and fourth partitions of table space TSNAME in database DBNAME for read-only access|```-START DATABASE (DBNAME) SPACENAM (TSNAME) PART (3,4) ACCESS (RO)```|
|Start all table spaces that begin with "T" and end with the string "SNAME" in database DBNAME for read and write access|```-START DATABASE (DBNAME) SPACENAM (T*SNAME) ACCESS (RW)```|
|Start the distributed data facility (DDF) if it is not already started |```-START DDF``` |
|Start all stored procedures  |```-START PROCEDURE ``` |
|Start USERPRC1 and USERPRC2 stored procedures  |```-START PROCEDURE(USERPRC1,USERPRC2) ``` |
|Load or Reload the profile table into a data structure in memory  |```-START PROFILE ``` |
|Start the resource limit facility with ID=01  |```-START RLIMIT ID=01 ``` |
|Start DB2 MONITOR trace with CLASS, DEST and IFCID attibutes  |```-START TRACE(MON) CLASS(1) DEST(SMF) IFCID(400) ``` |
|Start DB2 ACCOUNTING trace to collect In-DB2 time data  |```-START TRACE(ACCTG) CLASS(2)  IFCID(3) ``` |
|Start DB2 ACCOUNTING trace to collect I/O and lock wait times data  |```-START TRACE(ACCTG) CLASS(3)  IFCID(3) ``` |
|Start DB2 ACCOUNTING trace to collect Package/DBRM In-DB2 time data  |```-START TRACE(ACCTG) CLASS(7)  IFCID(3,239) ``` |
|Start DB2 ACCOUNTING trace to collect Package/DBRM I/O and lock wait times data  |```-START TRACE(ACCTG) CLASS(8)  IFCID(3,239) ``` |
|Start DB2 ACCOUNTING trace to collect Package detail data  |```-START TRACE(ACCTG) CLASS(10)  IFCID(239) ``` |
|Start DB2 ACCOUNTING trace with no In-DB2 or I/O and lock wait times data  |```-START TRACE(ACCTG) CLASS(1)  IFCID(3) ``` |
|Start DB2 ACCOUNTING trace with no package info  |```-START TRACE(ACCTG) CLASS(11)  IFCID(3,200) ``` |
|Start DB2 ACCOUNTING trace to collect Installation-defined accounting record data  |```-START TRACE(ACCTG) CLASS(4)  IFCID(151) ``` |
|Start DB2 ACCOUNTING trace to collect Time spent processing IFI requests data  |```-START TRACE(ACCTG) CLASS(5)  IFCID(187) ``` |
|Start DB2 AUDIT trace to collect Explicit GRANT and REVOKE data  |```-START TRACE(AUDIT) CLASS(2)  IFCID(141) ``` |
|Start DB2 AUDIT trace to collect CREATE, ALTER, and DROP operations against audited tables data  |```-START TRACE(AUDIT) CLASS(3)  IFCID(142) ``` |
|Start DB2 AUDIT trace to collect First change of audited object data  |```-START TRACE(AUDIT) CLASS(4)  IFCID(143) ``` |
|Start DB2 AUDIT trace to collect First read of audited object data  |```-START TRACE(AUDIT) CLASS(5)  IFCID(144) ``` |
|Start DB2 AUDIT trace to collect Bind time information about SQL statements that involve audited objects  |```-START TRACE(AUDIT) CLASS(6)  IFCID(145) ``` |
|Start DB2 AUDIT trace to collect Installation-defined audit record data  |```-START TRACE(AUDIT) CLASS(9)  IFCID(146) ``` |
|Start DB2 STATISTICS trace to collect Installation-defined statistics record data  |```-START TRACE(STAT) CLASS(2)  IFCID(152) ``` |
|Start DB2 STATISTICS trace to collect Deadlock, lock escalation, group buffer pool, data set extension information, and indications of long-running uncommitted reads, and active log space shortages data  |```-START TRACE(STAT) CLASS(3)  IFCID(172,196,250,258,261,262,313,330,337) ``` |
|Start DB2 STATISTICS trace to collect DB2 data sharing statistics record data  |```-START TRACE(STAT) CLASS(5)  IFCID(230) ``` |
|Start DB2 STATISTICS trace to collect Storage statistics for the DB2 subsystem  |```-START TRACE(STAT) CLASS(6)  IFCID(225) ``` |
|Start DB2 STATISTICS trace to collect DRDA location statistics  |```-START TRACE(STAT) CLASS(7)  IFCID(365) ``` |
|Start DB2 STATISTICS trace to collect Data set I/O statistics|```-START TRACE(STAT) CLASS(8)  IFCID(199) ``` |
|Start DB2 STATISTICS trace to aggregate CPU and wait time statistics by connection type|```-START TRACE(STAT) CLASS(9)  IFCID(369) ``` |
|Start DB2 PERFORMANCE trace to collect Detailed lock information  |```-START TRACE(PERFM) CLASS(7)  IFCID(21,105,106,107,223) ``` |
|Start DB2 PERFORMANCE trace to collect Installation-defined performance record data  |```-START TRACE(PERFM) CLASS(15)  IFCID(154) ``` |
|Start DB2 PERFORMANCE trace to collect Event-based console messages |```-START TRACE(PERFM) CLASS(18)  IFCID(197) ``` |
|Start DB2 PERFORMANCE trace to collect  Data set open and close activity data |```-START TRACE(PERFM) CLASS(19)  IFCID(370,371) ``` |
|Start DB2 PERFORMANCE trace to collect  Data sharing coherency detail data |```-START TRACE(PERFM) CLASS(21)  IFCID(255,259,263) ``` |
|Start DB2 PERFORMANCE trace to collect Authorization exit parameters data |```-START TRACE(PERFM) CLASS(22)  IFCID(314) ``` |
|Start DB2 PERFORMANCE trace to collect Language environment runtime diagnostics data |```-START TRACE(PERFM) CLASS(23)  IFCID(327) ``` |
|Start DB2 PERFORMANCE trace to collect Stored procedure detail data |```-START TRACE(PERFM) CLASS(24)  IFCID(380,499) ``` |
|Start DB2 MONITOR trace to collect Entry or exit from DB2 event signaling data |```-START TRACE(MONITOR) CLASS(2)  IFCID(232) ``` |
|Start DB2 MONITOR trace to collect Installation-defined monitor record data |```-START TRACE(MONITOR) CLASS(4)  IFCID(155) ``` |
|Start DB2 MONITOR trace to collect Time spent processing IFI request data |```-START TRACE(MONITOR) CLASS(5)  IFCID(187) ``` |
|Start DB2 MONITOR trace to collect Changes to tables created with DATA CAPTURE CHANGES |```-START TRACE(MONITOR) CLASS(6)  IFCID(185) ``` |
|Start DB2 MONITOR trace to enable statement level accounting data |```-START TRACE(MONITOR) CLASS(9)  IFCID(124) ``` |
|Start DB2 MONITOR trace to collect Package detail for buffer manager, lock manager and SQL statistics. One of the following traces must also be activated before the IFCID 0239:  records are written: Accounting class 7, Accounting class 8, Monitor class 7, Monitor class 8|```-START TRACE(MONITOR) CLASS(10)  IFCID(239) ``` |


## Stop commands

| Command | Description | 
|---------|:------------|
|Stop DB2|```-STOP DB2(DB2SSID)``` |
|Stop database. Make the specified database unavailable for use|```-STOP DATABASE```|
|Stop table space TSNAME in database DBNAME and close the data sets that belong to that table space|```-STOP DATABASE (DBNAME) SPACENAM (TSNAME)```|
|Stop all table spaces with names that begin with "T" and end with the "SNAME" string in database DBNAME|```-STOP DATABASE (DBNAME) SPACENAM (T*SNAME)```|
|Stop the distributed data facility (DDF) |```-STOP DDF``` |
|Prevent DB2 from accepting SQL CALL statements for one or more stored procedures   |```-STOP PROCEDURE ``` |
|Stop USERPRC1 and USERPRC2 stored procedures  |```-STOP PROCEDURE(USERPRC1,USERPRC2) ``` |
|Load or Reload the profile table into a data structure in memory  |```-STOP PROFILE ``` |
|Stop the resource limit facility. STOP RLIMIT resets all previously set limits to infinity and resets the accumulated time to zero.  |```-STOP RLIMIT ``` |
|Stop tracing |```-STOP TRACE ``` |
|Terminate all executions of a DB2 utility jobs |```-TERM UTIL(*)  ``` |
|Terminate execution of a DB2 utility job with UTILID=UTILID |```-TERM UTIL(UTILID)  ``` |




