# How to restore datasets anywhere where HSM is working

1. Issue command:
```
tso HLIST DSNAME('YOURDATASET') BOTH
```

2. If there are any backups created, their names, date of creation 
and the generation number are displayed on the screen.

3. Choose which generation you need (in the example below it's the last one - generation 0) and issue command:
```
tso HRECOVER 'YOURDATASET' GENERATION(0)
```

4. You will see messages, which shows the request was issued to HSM.  
It will take a little while for HSM to do the recover so wait a minute and press enter again.

**Note:** Once HSM completes the restore request,  you should get a message from HSM showing the restore was successful.  If the restore was NOT successful, you will get HSM messages for the failure and you should screen print the messages so they can be used to determine why the restore failed.  