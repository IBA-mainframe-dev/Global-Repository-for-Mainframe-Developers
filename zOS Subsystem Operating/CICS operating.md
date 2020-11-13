
1. Start CICS (for RS25 s CTSRS25J)    
2. logon CTSRS25J 
3. Clear screen via ```CLEAR```
4. QMF from Cics --> standard transaction QMFE (but may be not activated by support)    
5. Enter next command: ```qmfe```
6. Select ```PF6``` to put your SQL     

**Below is the example for using transaction N051 from group ```navngrp```**
(It may be one of default samples - but may be not activated by support)
7. Clear screen via ```CLEAR```
8. Enter without commas next command: ```cemt i trans(N051)```
9. Press ```PF3```
10. Clear screen via ```CLEAR```
11. Enter ```N051```
12.  Fill next values:

MAJOR SYSTEM ...: O          ORGANIZATION    
ACTION .........: d                          
OBJECT .........: em                         
SEARCH CRITERIA : en                         
DATA ...........: % 
       
If after 8. step transaction was not found then:
8'. ```ceda i group(navngrp)``` and then issue 8') - 12') steps.

**Enter next command ```d8ps```:**
```
ceda dis group(*) 
```
```
ceda DIS GROUP(DFHWSAT)   
```

LOGOFF -CESF LOGOFF