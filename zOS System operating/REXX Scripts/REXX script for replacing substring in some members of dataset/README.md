# REXX script for replacing substring in some members of dataset

** MASSREPL was created to replace substring with new one in some members of dataset on z/OS **

[**Link to REXX script sources (MASSREPL)**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/REXX%20Scripts/REXX%20script%20for%20replacing%20substring%20in%20some%20members%20of%20dataset/MASSREPL)

** Script configuration before execution **
1. Replace dataset's members names MEMBER1,MEMBER2,.. with members you need:
* `membersToProcess='MEMBER1 MEMBER2 MEMBER3 MEMBER4'`
2. Put the script to your REXX-library

  
**Execution:**

Run JCL job with step:

```
//RUNSCRPT  EXEC PGM=IKJEFT01,DYNAMNBR=30,REGION=0M,         
//          PARM='MASSREPL USR01.USRHLQ.USRLIB HLQ1 HLQ2'
//SYSEXEC   DD   DSN=USR01.USRHLQ.REXX,DISP=SHR                  
//SYSTSPRT  DD   SYSOUT=*                                    
//SYSTSIN   DD   DUMMY                                       
```

* `USR01.USRHLQ.USRLIB` - dataset with members to be changed

* `HLQ1 HLQ2` - substring HLQ1 to be replaced with substring HLQ2
