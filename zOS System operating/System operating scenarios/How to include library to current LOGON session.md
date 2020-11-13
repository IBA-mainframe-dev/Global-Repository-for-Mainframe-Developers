# Dynamic library inclusion to current LOGON session

*"How to concatenate my datasets to ISPPLIB, ISPEXEC etc."*
1. Open "Current Data Set Allocations" page (Type it in command line at any ISPF page):
```
TSO ISRDDN
```
2. Save current list of data set allocations into \<user>.ISRDDN.CLIST: 
```
CLIST
```
3. Open \<user>.ISRDDN.CLIST and concatenate your libraries to allocation command of specific DD.
4. Go to READY page and execute command:
```
EXEC '<user>.ISRDDN.CLIST'
```