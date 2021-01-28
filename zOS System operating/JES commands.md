# This document contains various day-to-day and rare JES commands.

## How to display JES2 info

| Description       | Command          |
|-------------------|:-----------------|
|Display active jobs|`/$D A`|
|Display all jobs, including TSU and STC|`/$D A,X`|
|Display tasks running under JES2|`/$D JES2`|
|Display information about JES2 devices|`/$D U`|
|Display Number of Queued Jobs|`/$D Q`|
|Display initialization command and parmlib|`/$D INITINFO`|
|Display SPOOL data set characteristics|`/$D SPOOLDEF`|
|Display how full is the SPOOL|`/$D SPOOL`|
|Display which jobs are using more than 1% of the SPOOL|`/$D JQ,SPL=(%>1)`| 


## How to purge a job 

| Description       | Command          |
|-------------------|:-----------------|
|Purge `job-name` from the system|`/$P J'job-name'`|
|Purge jobs that match `job-mask`|`/$P JQ,JM=job-mask`|
|Purge the output of all Jobs belonging to classes "A,B and C" that are older than a day|`/$P OJOBQ,Q=ABC,DAYS>1`|
|Purge all Jobs that are more than 3 days old|`/$P OJOBQ,ALL,PROTECTED,DAYS>3`|

## JES2 Automatic commands

When you code this command, JES2 establishes a starting point `T(hhh.mm)` (when to begin issuing a command), and an interval `I(sssss)` (when to repeat a command).

| Description       | Command          |
|-------------------|:-----------------|
|Display automatic commands you are authorized to see|`/$T A,ALL`|
|Issue `$jes-command` every 90 seconds|`/$T A,I=90,'$jes-command'`|
|Issue `$d u` every 24 hours from starting point 12:30 AM|`/$T A,T=00.30,I=86400,'$d u'`|
|Issue MVS command `SEND 'message-text'` every 20 seconds|`/$T A,I=20,'$VS,''SEND ''message-text'''''`|
|Cancel all automatic commands|`/$C A,ALL`|
|Cancel automatic command with ID = 2|`/$C A2`|
