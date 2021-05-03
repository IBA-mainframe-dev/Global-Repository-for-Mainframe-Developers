# How to restore deleted dataset from HSM BACKUP copy

Sometimes you can inadvertently delete some of your datasets (or member(s) of your library).
If HSM is active in your system, you can try to restore deleted dataset from HSM BACKUP copy (if HSM has it).

For example, to check if HSM has backup copy of file `USC.MAS430.CLIST` , from any ISPF panel issue command:   

```
tso hlist dsname('USC.MAS430.CLIST') bcds 
```

Response will look like                                                                                                      
```
DSN=USC.MAS430.CLIST               BACK FREQ = ***  MAX ACTIVE BACKUP VERSIONS = *** 
                                                                                                     
  BDSN=SYSHSM.BACK.T170920.USC.MAS430.B1004        BACKVOL=LC0771   FRVOL=MZTS33                     
  BACKDATE=21/01/04  BACKTIME=20:09:16  CAT=YES  GEN=000  VER=007  UNS/RET= NO                       
  RACF IND=NO  BACK PROF=NO  NEWNM=NO  NOSPH=*** GVCN=*** RETDAYS=*****                              
  ENCRYPTION TYPE=*******                                                                            
  KEYLABEL=****************************************************************                          
                                                                                                     
  BDSN=SYSHSM.BACK.T070620.USC.MAS430.B0029        BACKVOL=LC0068   FRVOL=MZTS36                     
  BACKDATE=20/01/29  BACKTIME=20:06:05  CAT=YES  GEN=001  VER=006  UNS/RET= NO                       
  RACF IND=NO  BACK PROF=NO  NEWNM=NO  NOSPH=*** GVCN=*** RETDAYS=*****                              
  ENCRYPTION TYPE=*******                                                                            
  KEYLABEL=****************************************************************                          
                                                                                                     
 TOTAL BACKUP VERSIONS = 0000000002                                                                  
                                                                                                     
 ARC0140I LIST COMPLETED,       12 LINE(S) OF DATA OUTPUT                                         
 *** 
```

To restore more up-to-date copy from 2 that has HSM, issue command
```
tso hrecover 'USC.MAS430.CLIST' generation(0)
```
You will see messages, which shows the request was sent to HSM.  
It will take a some time while HSM doing the recover, so wait a little bit and press enter again.
When restore ends, you will see message like
```
ARC0778I DATA SET/FILE USC.MAS430.CLIST WAS RECOVERED FROM A BACKUP MADE AT
ARC0778I (CONT.) 20:09:16 ON 2021/01/04                                  
ARC1000I USC.MAS430.CLIST RECOVER PROCESSING ENDED                         
***                     
```
showing that restore was successful.  If the restore was NOT successful, you will get HSM messages for the failure and you should screen print the messages so they can be used to determine why the restore failed.  
