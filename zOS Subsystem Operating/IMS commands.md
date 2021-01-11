# This document contains day-to-day IMS subsystem commands.

## Start IMS 15.1

First you need to start IRLM:
```
/S IMS15RL1
```
And then IMS control region:
```
/S IMS15CR1
```
In SDSF you will see a list of parameters

After starting, the following message will appear (it will be white):
```
*xx DFS996I IMS READY
```
where xx - is an outstanding message number

In the case of a cold start, enter:
```
/xx,/NRE CHKPT 0 FORMAT ALL
```
But if you do a warm start:
```
/xx,/NRE
```
If IMS started successfully, you should see the message
```
DFS994I COLD START COMPLETED.
or
DFS994I WARM START COMPLETED.
```

## To restart a badly stopped IMS, you need to type:
```
/xx,/ERE OVERRIDE
```

## To stop IMS
```
/xx,/CHE FREEZE 
```

Where ```xx``` - is the WTO message number. Or just make cancel ```IMSA41CR```.
Then, when restarting, you must issue: ```xx / ERE OVERRIDE```

```
/STO REGION 3
```
Where ```3``` is the number of region.

## Abend: U0456 - PSB locked because of prior program failure:
```
/dis PGM DSN8IC0 
```
```
/sto PGM DSN8IC0 
```
```
/dis PGM DSN8IC0 
```
```
/start PGM DSN8IC0
```
