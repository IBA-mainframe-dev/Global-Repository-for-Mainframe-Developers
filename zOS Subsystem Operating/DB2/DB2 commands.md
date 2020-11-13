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
|Start DB2|```-START DB2``` |
|Start database. Make the specified database available for use|```-START DATABASE```|
|Start the distributed data facility (DDF) if it is not already started |```-START DDF``` |
|Start an external function that is stopped  |```-START FUNCTION SPECIFIC ``` |
|Activate the definition of a stored procedure that is stopped or refreshes one that is stored in the cache. You can qualify stored procedure names with a schema name.  |```-START PROCEDURE ``` |
|Load or Reload the profile table into a data structure in memory  |```-START PROFILE ``` |
|Start the resource limit facility (governor) and specifies a resource limit specification table for the facility to use. You can issue START RLIMIT even if the resource limit facility is already active.  |```-START RLIMIT ``` |
|Start DB2 traces  |```-START TRACE ``` |
|Start DB2 MONITOR trace with CLASS, DEST and IFCID attibutes  |```-START TRACE(MON) CLASS(1) DEST(SMF) IFCID(400) ``` |

## Stop commands

| Command | Description | 
|---------|:------------|
|Stop DB2|```-STOP DB2``` |
|Stop database. Make the specified database unavailable for use|```-STOP DATABASE```|
|Stop the distributed data facility (DDF) |```-STOP DDF``` |
|Prevent DB2 from accepting SQL statements with invocations of the specified functions  |```-STOP FUNCTION SPECIFIC ``` |
|Prevent DB2 from accepting SQL CALL statements for one or more stored procedures   |```-STOP PROCEDURE ``` |
|Load or Reload the profile table into a data structure in memory  |```-STOP PROFILE ``` |
|Stop the resource limit facility. STOP RLIMIT resets all previously set limits to infinity and resets the accumulated time to zero.  |```-STOP RLIMIT ``` |
|Stop tracing |```-STOP TRACE ``` |
|Terminate all executions of a DB2 utility jobs |```-TERM UTIL(*)  ``` |
|Terminate execution of a DB2 utility job with UTILID=UTILID |```-TERM UTIL(UTILID)  ``` |




