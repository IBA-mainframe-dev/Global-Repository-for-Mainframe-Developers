# REXX script for changing parameters values in config file

** CHNGPARM was created to change parameters values in config file on z/OS **

[**Link to REXX script sources (CHNGPARM)**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/REXX%20Scripts/REXX%20script%20for%20changing%20parameters%20values%20in%20config%20file/CHNGPARM)

** Script configuration before execution **
1. Create configuration file like USR01.USRHLQ.CONFIG(USRVAR):

```
//     SET PARM1=OLDVAL1           
//     SET PARM2=OLDVAL2
```
2. Put the script to your REXX-library

  
**Execution:**

Run JCL job with step:

```
//RUNSCRPT  EXEC PGM=IKJEFT01,DYNAMNBR=30,REGION=0M,                
//          PARM='CHNGPARM USR01.USRHLQ.CONFIG(USRVAR),PARM1/NEW1,
//                PARM2/NEW2'                                      
//SYSEXEC   DD   DSN=USR01.USRHLQ.REXX,DISP=SHR                      
//SYSTSPRT  DD   SYSOUT=*                                           
//SYSTSIN   DD   DUMMY                                                                                  
```

* `USR01.USRHLQ.CONFIG(USRVAR)` - configuration file to be changed

* `PARMn/NEWn` - NEWn is a new value of parameter PARMn
