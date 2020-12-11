# This document contains various day-to-day and rare DB2 subsystem commands.

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




