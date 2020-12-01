# How to convert hexadecimal date to a readable date on z/OS?
If you need to convert hexadecimal time to regular format, you can use the REXX exec in the TOD member of the SYS1.SBLSCLI0 data set, which belongs to the MVS Interactive Problem Control System (IPCS)

Command syntax: 
```
TOD STCK_TIME {, TIME_ZONE}                  
  STCK_TIME: A STRING OF HEXADECMIAL DIGITS  
  TIME_ZONE: NUMBER OF HOURS EAST(-)/WEST(+) OF GMT
```
For instance, the following exec statement converts the value of 7A273F:
```
TSO TOD 7A273F
or
TSO EXEC ‘SYS1.SBLSCLI0(TOD)’ ‘7A273F’
```
The result will be:
```
7A273F00 00000000 : 1968/02/06 00:47:48.445184  TIMEZONE: 0000000000000000
```
Note: library SBLSCLI0 may have a different high level qualifier (HLQ)
