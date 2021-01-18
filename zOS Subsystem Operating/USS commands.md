# This document contains various day-to-day USS commands.

## z/OS console commands

The following commands are z/OS (MVS) commands that are issued from MCS or EMCS consoles.

| Description | Command | 
|---------|:------------|
|Displays the information about all running processes |```D OMVS,A=ALL``` |
|Displays the information defined in the BPXPRMxx |```D OMVS,O``` |
|Displays the information about the mounted HFS |```D OMVS,F``` |
|Displays the information about the process ID |```D OMVS,PID=<pid>``` |
|Displays the information about kernel and data spaces |```D A,OMVS``` |
|Forces a process ID to end |```F BPXOINIT,FORCE,PID=<PID>``` |
|Sets a new configuration of BPXPRMxx member and makes a syntax check |```SET OMVS=xx``` |

## z/OS UNIX shell commands

The following commands are issued from the OMVS shell.

| Description | Command | 
|---------|:------------|
|Displays the current pathname |```pwd``` |
|Displays the contents and extended attributes of the current directory |```ls -alWE``` |
|Displays the information about all running processes |```ps -ef``` |
|Displays information about syntax and use of the command ls |```man ls``` |
|Displays the information about the mounted HFS |```df -P``` |	
|Searches the HFS from the root to find the file specified |```find / -name setup.sh``` |	

## z/OS UNIX shutdown

Attention! Read recommended shutdown procedures before executing the command.

```
F OMVS,SHUTDOWN
```

## z/OS UNIX restart

```
F OMVS,RESTART
```

The ```F OMVS,RESTART``` command restarts the z/OS UNIX environment. This involves the following:
1. Once the restart command has been accepted, indicated by the following message:
```
*BPXI058I OMVS RESTART REQUEST ACCEPTED
```
The first step in the restart process is to re-initialize the kernel and LFS. This includes starting up all physical file systems.
2. BPXOINIT is restarted and it will re-establish itself as process ID 1.
3. BPXOINIT re-establishes the checkpointed processes as follows:
All checkpointed processes that are still active are re-established and those that are not found are not re-established and will have their checkpointed resources cleaned up.
4. After BPXOINIT completes its initialization, it will restart /etc/init or /usr/sbin/init to begin full function initialization of the z/OS UNIX environment. /etc/init performs its normal startup processing, invoking /etc/rc.
5. After /etc/init has completed full function initialization, a BPXI0041 message is issued indicating z/OS UNIX initialization is complete.
```
BPXI004I OMVS INITIALIZATION COMPLETE
```

## Superkill function

1. Send a regular KILL signal by issuing, ```kill -s KILL pid```
2. Wait 3 seconds
3. Then send a superkill to force termination - ```kill -K pid```
