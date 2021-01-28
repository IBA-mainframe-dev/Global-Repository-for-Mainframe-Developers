# This document contains many of the commonly used commands (with brief descriptions) for FTP and TCP/IP, as well as related z/OS, z/VM, VSE, Linux, and VTAM commands.

## TCP/IP Commands for TSO/E

Note: The following TCP/IP commands should be done from the TSO command panel or the READY prompt.
Note: hostname may be the IP address of the host, or the host name of the host.

| Description       | Command          |
|-------------------|:-----------------|
|Connect to remote host to get/put files. Defaults to port 21.|```FTP hostname {port}```|
|Validate TCP/IP configuration.|```HOMETEST```|
|Display network status of local host. Use ? for list of options.|```NETSTAT option {TCP procname}```|
|Display port connections for the TCP/IP stack.|```NETSTAT ALLCON\|CONN```|
|Display ARP cache for the TCP/IP stack.|```NETSTAT ARP ALL\|ipaddress```|
|Display the status of the device(s) and link(s) for the TCP/IP stack.|```NETSTAT DEV```|
|Display routing information for the TCP/IP stack. (Different views).|```NETSTAT GATE\|ROUTE```|
|Display IP address(es) for the stack.|```NETSTAT HOME```|
|Sends an echo request to a host name or address to determine if the computer is accessible. Use ? for list of options.|```PING hostname```|
|Log on to remote host. By default, port 23 is used. Use ? for list of options.|```TELNET hostname {port}```|
|Trace hops from this host to destination host. Use ? for list of options.|```TRACERTE hostname```|

## z/OS Console Commands for TCP/IP

Note: If multiple stacks are running, you must identify the stack in the procname field.

| Description       | Command          |
|-------------------|:-----------------|
|Display list names and status of TCP/IP stacks.|```D TCPIP```|
|Display list of TCP/IP display options. These include -NETSTAT, TELNET, HELP, DISPLAY, VARY, OMPROUTE, SYSPLEX, STOR.|```D TCPIP,{procname},HELP```|
|Display socket information for the TCP/IP stack.|```D TCPIP,{procname},Netstat,ALLCONN\|CONN```|
|Display contents of ARP cache for the TCP/IP stack.|```D TCPIP,{procname},Netstat,ARP```|
|Display Device and link status for the TCP/IP stack.|```D TCPIP,{procname},Netstat,DEVlinks```|
|Display the IP address(es) for the TCP/IP stack.|```D TCPIP,{procname},Netstat,HOME```|
|Display the routing table for the TCP/IP stack.|```D TCPIP,{procname},Netstat,ROUTE```|
|Display list of TCP/IP vary options. These include - HELP, OBEYFILE, PKTTRACE, DATTRACE, START, STOP, PURGECACHE|```V TCPIP,{procname},HELP```|
|Purge ARP cache for the specified adapter (linkname from NETSTAT,DEVLINKS).|```V TCPIP,{procname},PURGECACHE,linkname```|
|Start or stop the device name identified in NETSTAT DEV output.|```V TCPIP,{procname},START\|STOP,devname```|
|Performs specified function for TELNET.|```V TCPIP,{procname},Telnet,xxxx```|
|Enables/disables lu as VTAM session candidate|```ACT\|INACT,luname```|
|Blocks new connections.|```QUIESCE```|
|Ends QUIESCEd state.|```RESUME```|
|Ends telnet connections and closes port.|```STOP```|

## Related z/OS Console Commands

Note: The value for "c's and d's" in the following Display Matrix (D M) command is optional, but if included, must be in parentheses ().

| Description       | Command          |
|-------------------|:-----------------|
|MIH value for device.|```D IOS,MIH,DEV=dddd```|
|Status of CHPID cc, or summary of all CHPIDs if (cc) is not provided. Display CHPIDs/device status or summary of CHPID status of all devices if (dddd) is not provided.|```D M=CHP{(cc)}\|DEV{(dddd)}```|
|Display information for all devices by selected status.|```D U,,ALLOC\|OFFLINE\|ONLINE```|
|Display status of devices starting at device dddd for nnn number of devices (default 16).|```D U,,,dddd{,nnn}```|
|Set MIH time for specified device.|```SETIOS MIH,DEV=ddd,TIME=mm:ss```|
|Vary device(s) offline or online.|```V dddd\|dddd-dddd,OFFLINE\|ONLINE```|
|Configure online/offline CHPID cc to MVS & hardware.|```CF CHP(cc),ONline\|OFFline```|


## z/VM Operator Commands

Note: Requires class B authority to issue the following commands.

| Description       | Command          |
|-------------------|:-----------------|
|Display MIH times for devices.|```Q MITIME```|
|Display status of OSA devices.|```Q OSA ACTIVE\|ALL```|
|Display status of real device(s).|```Q rdev\|rdev-rdev```|
|Display path status to real device(s) (PIM, PAM, LPM).|```Q PATHS rdev\|rdev-rdev```|
|Display real CHPID status.|```Q CHPID cc```|
|Vary device(s) off or online|```VARY OFF\|ON rdev\|rdev-rdev```|
|Change the status of a path to device(s).|```VARY OFF\|ON PATH cc FROM\|TO rdev\|rdev-rdev```|
|Configure a CHPID off or on to both hardware and software.|```VARY OFF\|ON CHPID cc```|

## z/VM TCP/IP Commands

Note: Your CMS userid must be linked to the TCPMAINT 592 minidisk to execute the following commands.
Note: hostname may be the IP address of the host, or the host name of the host.

| Description       | Command          |
|-------------------|:-----------------|
|Connect to remote host to get/put files. Defaults to port 21. Enter FTP ? for list of options.|```FTP hostname {port}```|
|Validate TCP/IP configuration.|```HOMETEST```|
|display network interfaces.|```IFCONFIG```|
|Start or stop the specified network interface.|```IFCONFIG interface UP\|DOWN```|
|Display network status of local host. Use ? for list of options.|```NETSTAT option```|
|Display all port connections for the TCP/IP stack.|```NETSTAT ALLCON\|CONN```|
|Display ARP cache for the TCP/IP stack.|```NETSTAT ARP *\|ipaddress```|
|Display the status of the device(s) and link(s) for the TCP/IP stack.|```NETSTAT DEV```|
|Display TCP/IP routing information.|```NETSTAT GATE```|
|Display IP address(es) in TCP/IP stack.|```NETSTAT HOME```|
|Start or stop the device name identified in NETSTAT DEV output.|```NETSTAT OBEY START\|STOP devname```|
|Sends an echo request to a host name or address to determine if the computer is accessible. Use ? for list of options.|```PING hostname```|
|Log on to remote host. By default, port 23 is used. Use ? for list of options.|```TELNET hostname {port}```|
|Trace hops from this host to destination host. Use ? for list of options.|```TRACERTE hostname```|

## VSE TCP/IP Commands

Note: hostname may be the IP address of the host, or the host name of the host.

| Description       | Command          |
|-------------------|:-----------------|
|Sends an echo request to a host name or address to determine if the computer is accessible.|```PING hostname```|
|Display contents of ARP cache for the TCP/IP stack.|```Query ARP{,IP=hostname}```|
|Display port connections for the TCP/IP stack.|```Query CON{,IP=hostname}```|
|Display link status.|```Query LINKs{,ID=name}```|
|Display contents of subnet mask table.|```Query MASKs```|
|Display routing table for the TCP/IP stack.|```Query ROUTes{ID=name\|,IP=hostname}```|
|Display device status.|```STATUS dddd```|
|Start a link in the TCP/IP stack.|```START LINK=name```|
|Suspends attempts to activate a link. Note: Use with CTCA and cross-partition links (not OSA).|```STOP LINK=name```|
|Trace hops from this host to destination host.|```TRACERT hostname```|

## VTAM Commands

VTAM commands related to OSA cards.

| Description       | Command          |
|-------------------|:-----------------|
|Display network named in ID field. Additional parameters that may be added: 1) ,SCOPE=ONLY\|ACT\|ALL\|INACT 2) ,E - Gives extended information about the node.|```D NET,ID=name```|
|Shows status of all active major nodes or applications.|```D NET,MAJNODES\|APPLS```|
|Lists nodes in pending states.|```D NET,PENDING```|
|Display list of TRLEs.|```D NET,TRL```|
|Display status of specific TRLE. (Use this command to display the devices assigned to a QDIO (or MPC) OSA-Express resource.)|```D NET,TRL,TRLE=trlename```|
|Deletes all inactive TRLEs.|```V NET,ACT,ID=ISTTRL,UPDATE=ALL```|
|Activates the VTAM resource identified by the name.|```V NET,ACT,ID=name```|
|Inactivates the VTAM resource identified by the name. 1) ,F\|I\|U - Deactivate FORCE, IMMEDIATE, or UNCONDITIONAL (if normal inact fails).|```V NET,INACT,ID=name```|

## TCP/IP Commands for OS/2

Commands must be done from a command prompt window.
The commands are listed in upper case for presentation only. They should be entered in lower case.
Note: hostname may be the IP address of the host, or the host name of the host.

| Description       | Command          |
|-------------------|:-----------------|
|Display ARP cache. Use -? for options.|```ARP -A```|
|Connect to remote host to get/put files. Defaults to port 21. Use -? for list of options. NETSTAT command output may roll through the OS/2 window. To prevent this, add \|more to the end of the netstat command. (Or direct output to a file by adding >filename.TXT to the end of the NETSTAT command.)|```FTP hostname {port}```|
|Sends request to an IP address and returns information about the hostname.|```HOST ipaddress```|
|Display a list of options.|```NETSTAT -?```|
|Display host network address.|```NETSTAT -A```|
|Display host ICMP statistics.|```NETSTAT -C```|
|Display host name for specified IP address.|```NETSTAT -H```|
|Display host IP statistics.|```NETSTAT -I```|
|Display host network interface details. (Like MAC, speed, and statistics)|```NETSTAT -N```|
|Display host ARP cache.|```NETSTAT -P```|
|Display host routes.|```NETSTAT -R```|
|Display host sockets.|```NETSTAT -S```|
|Display host TCP statistics.|```NETSTAT -T```|
|Display host UDP statistics.|```NETSTAT -U```|
|Sends an echo request to a host name or address to determine if computer is accessible. (To cancel, use Ctrl + C.) Use -? for list of options.|```PING hostname```|
|Log on to remote host. By default, port 23 is used. Use -? for list of options.|```TELNET {-p port} hostname```|
|Trace hops from this host to destination host. Use -? for list of options.|```TRACERTE hostname```|

## TCP/IP Commands for Windows

Commands should work for Windows 95, 98, NT, & 2000.
Commands must be done from a command prompt window.
The commands are listed in upper case for presentation only. They should be entered in lower case.
Note: hostname may be the IP address of the host, or the host name of the host.

| Description       | Command          |
|-------------------|:-----------------|
|Display ARP cache. Use -? for options.|```ARP -A```|
|Connect to remote host to get/put files. Defaults to port 21. Use -? for list of options. Note: The output of the NETSTAT command may roll through your window. To prevent this, add \|more to the end of the netstat command. (Or direct the output to a file by adding >filename.TXT to the end of the NETSTAT command.)|```FTP hostname```|
|Display a list of options.|```NETSTAT -?```|
|Display host socket information.|```NETSTAT -A```|
|Display host Ethernet statistics.|```NETSTAT -E```|
|Display host addresses and ports numerically.|```NETSTAT -N```|
|Display connection information for the selected protocol.|```NETSTAT -P TCP\|UDP\|IP```|
|Display host routes.|```NETSTAT -R```|
|Display host statistics.|```NETSTAT -S```|
|Sends an echo request to a host name or address to determine if the computer is accessible. Use -? for list of options.|```PING hostname```|
|Log on to remote host. By default, port 23 is used. Use -? for list of options.|```TELNET hostname {port}```|
|Trace hops from this host to destination host. Use -? for list of options.|```TRACERT hostname```|

## TCP/IP Commands for Linux

The commands are listed in upper case for presentation only. They should be entered in lower case.

| Description       | Command          |
|-------------------|:-----------------|
|Display ARP cache. Use -? for options.|```ARP```|
|Display complete information about the Linux environment including network devices. ( \|MORE keeps output from scrolling.) ( > filename to send to a file.)|```DMESG\|MORE```|
|Connect to remote host to get/put files. Defaults to port 21. Use -? for options.|```FTP hostname\|ipaddress```|
|Display network interfaces (like LO,EN0,TR0)|```IFCONFIG```|
|Start or stop the selected network interface(EN0,TR0, etc). For the following NETSTAT commands, adding N to the option will display numerical output. AddingV will display verbose.|```IFCONFIG interface UP\|DOWN```|
|Display all sockets.|```NETSTAT -A```|
|Display interface table.|```NETSTAT -I```|
|Display host routes.|```NETSTAT -R```|
|Sends an echo request to a host to determine if the computer is accessible. Use -? for options.|```PING hostname\|ipaddress```|
|Displays IP routing table.|```ROUTE```|
|Log on to remote host. By default, port 23 is used. Use -? for options.|```TELNET hostname\|ipaddress {port}```|
|Trace hops from this host to destination host. Use -? for list of options.|```TRACEROUTE hostname\|ipaddress```|

## FTP Subcommands

| Description       | Command          |
|-------------------|:-----------------|
|ASCII transfer of text files.|```ascii```|
|BINARY transfer of binary files.|```binary```|
|Change directory on remote host.|```cd remote-directory```|
|Ends the FTP session. After close, OPEN a new connection or QUIT from FTP.|```close```|
|Delete the file from remote host.|```delete filename```|
|Gives full directory listing on remote host. file - file to be listed. destination - where to put listing. Both file and destination are optional.|```dir {file destination}```|
|Get a file from remote host.|```get filename {localfilename}```|
|Display a hash sign (#) every time a block of data is transferred. (Useful for large transfers.)|```hash```|
|Displays a description of the command. If a command is not specified, a list of commands is displayed.|```help {command}```|
|Change directory on your local machine.|```lcd directory```|
|Like dir, but less information.|```ls {file destination}```|
|Get multiple files from remote machine.|```mget file-list```|
|Put multiple files to remote machine.|```mput file-list```|
|Connect to named machine (IP or host name). Old connection must be CLOSEd first.|```open machine-name```|
|Turn prompting off/on for mget and mput.|```prompt```|
|Put a file onto remote host.|```put filename {remotefilename}```|
|Present Working Directory on remote host.|```pwd```|
|Exits FTP.|```quit\|bye```|
