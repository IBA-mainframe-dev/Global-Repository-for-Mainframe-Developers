# How to fix non working XMIT (enable NJE connection between two systems (for example - connection from ```<System1>``` to ```<System2>```))

On ```<System2>``` you need to define and start a NJE connection to ???RSPLEX01??? with the following commands: 

1.	```$add socket(???boston???),ipaddr=<System1_ip_addres_here>(???rs22.rocketsoftware.com???),port=<port_number>(??175??),node=<System1>21```
2.	```$add line(21),node=21,unit=tcpip```
3.	```$sline(21)```

On ```<System1>``` (the system in RSPLEX01 which handles NJE work) you need to define and start a connection to ```<System2>``` with the following commands:

1.	```$add socket(<ownname>),ipaddr=rs53.rocketsoftware.com,port=175,node=<ownnode>```
2.	```$add line(zzz),node=zzz,unit=tcpip```
3.	```$sline(zzz)```
4.	```$sn,n=rsplexi1```

You could  display ownnode value on <System2> by following command:
```$DNJEDEF,OWNNAME,OWNNODE```
