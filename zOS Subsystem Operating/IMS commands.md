# This document contains day-to-day IMS subsystem commands.

## Start IMS (for exaple for IMSA41 should be started next STCs):
* IMSA41M1
* IMSA41CR
* IMSA41JC
* IMSA41I1

1. Logon to IMS 
```
/DIS SUBSYS All
```
If your connection is stopped run next command:
```
/STA SUBSYS SN11
```
2. Clear screen via ```CLEAR```

3. Enter without commas next command: ```dsn8ps``` (always blank at the end!)

4. Fill next values:
```
MAJOR SYSTEM ...: O          ORGANIZATION    
ACTION .........: d                          
OBJECT .........: em                         
SEARCH CRITERIA : en                         
DATA ...........: %   
```
Or:

5. Enter without commas next command: ```dsn8pp``` (always blank at the end!)
6. Fill next values:
```
MAJOR SYSTEM ...: O          ORGANIZATION    
ACTION .........: d                          
OBJECT .........: pr                         
SEARCH CRITERIA : ri                         
DATA ...........: %          
```
**NOTE:** A sign of a normally working IMS - is a WTO message in the log: ```хх DFS996I IMS READY  MA41 ```
```
LOGOFFF --/SIGN OFF
```

## To restart a badly stopped IMS, you need to type (with all dots):
```
xx / ERE OVERRIDE.
```

## To stop IMS
```
xx / CHE FREEZE. 
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
