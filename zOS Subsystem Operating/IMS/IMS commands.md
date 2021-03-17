# This document contains day-to-day IMS subsystem commands.

**Through IMS console**:

Specify `@{ variable }`
| Description       | Command          |
|-------------------|:-----------------|
| Start IMS MPR Region | `/STA REG @{IMS_MPR}` |
| Start IMS Program | `/STA PGM @{IMS_PROGRAM}` |
| Start IMS Transaction | `/STA TRAN @{IMS_TRANSACTION}` |
| Start IMS Database | `/STA DB @{IMS_DATABASE}` |
| Unlock IMS Program | `/UNLOCK PGM @{IMS_PROGRAM}` |
| Unlock IMS Transaction | `/UNLOCK TRAN @{IMS_TRANSACTION}` |
| Unlock IMS Database | `/UNLOCK DB @{IMS_DATABASE}` |

**Through JCL jobs**:

Specify `@{ variable }`
| Description       | Command          |
|-------------------|:-----------------|
| Start IMS Address space  | [link](./JCL/STAIMSAS)|
| Start IMS MPR Region | [link](./JCL/STAMPR) |
| Start IMS Program | [link](./JCL/STAPGM) |
| Unlock IMS Transaction | [link](./JCL/UNLTRAN) |
| Unlock and Start IMS Transaction | [link](./JCL/UNLNSTAT) |
| Unlock IMS Database | [link](./JCL/UNLDB) |
| Unlock IMS Program | [link](./JCL/UNLPGM) |

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
where **xx** - is an outstanding message number

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
**NOTE:** A sign of a normally working IMS - is a WTO message in the log: ```хх DFS996I IMS READY```

## To restart a badly stopped IMS, you need to type:
```
/xx,/ERE OVERRIDE
```

## Log off from IMS
1. Type `/SIGN OFF`
2. Clear screen via `CLEAR` emulator option
3. To drop the VTAM terminal session to the IMS application, execute `/RCL`


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
