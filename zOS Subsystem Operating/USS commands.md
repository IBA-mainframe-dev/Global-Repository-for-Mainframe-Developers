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
|Display summary of z/OS UNIX |```D OMVS``` |
|Display z/OS UNIX options |```D OMVS,OPTIONS``` |
|Display BPXPRMxx limits |```D OMVS,LIMITS``` |
|Displays the last 10 (or less) failures |```D OMVS,MF``` |
|Displays up to 50 failures |```D OMVS,MF=ALL``` |
|Deletes the failure information log |```D OMVS,MF=PURGE``` |

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
|Display information about processes |```ps -A``` |
|Stop a process |```kill -s kill <pid>``` |
|Display interprocess communication information |```ipcs -w``` |

## z/OS UNIX shutdown

Attention! Read recommended shutdown procedures before executing the command.

```
F OMVS,SHUTDOWN
```

## Stopping BPXAS address spaces

```
F BPXOINIT,SHUTDOWN=FORKINIT
```

Attempting to shut down active BPXAS address spaces will result in the following message:

```
BPXM037I BPXAS INITIATOR SHUTDOWN DELAYED
```

Otherwise:

```
BPXM036I BPXAS INITIATORS SHUTDOWN.
$HASP395 BPXAS ENDED
```

## LFS soft shutdown

This command terminates UNIX activity on the system. The command also provides a method for unmounting all file systems and hardening the cached buffers to disk.

```
F BPXOINIT,SHUTDOWN=FILESYS
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

## BPXPRMxx parmlib member - ALTROOT

Establish the alternate sysplex root using the new ALTROOT statement in a BPXPRMxx parmlib member:
```
ALTROOT FILESYSTEM (’PLEX75.SYSPLEX.ROOTALT1.ZFS’) MOUNTPOINT(’/rootalt’)
```
1. Mount the ALTROOT file system as read-only and with AUTOMOVE=YES.
2. Establish it during OMVS initialization or with the SET OMVS command.

## Superkill function

1. Send a regular KILL signal by issuing, ```kill -s KILL pid```
2. Wait 3 seconds
3. Then send a superkill to force termination - ```kill -K pid```

## Changing OMVS parameter values

You can change the setting of some of the BPXPRMxx values dynamically using the SETOMVS or SET OMVS commands.

```
SET OMVS=(00,FS)
```

```
SETOMVS MAXPROCUSER=8
```

Values that can be changed are:
MAXPROCSYS - MAXPROCUSER - MAXFILEPROC - MAXFILESIZE - MAXCPUTIME MAXUIDS - MAXPTYS - MAXRTYS - MAXTHREADTASKS - MAXTHREADS - MAXMMAPAREA - MAXSHAREPAGES - MAXCORESIZE - MAXASSIZE - All IPC values FORKCOPY - STEPLIBLIST - USERIDALIASTABLE - PRIORITYPG - PRIORITYGOAL
