# This document contains useful day-to-day HSM dataset level commands

## LIST commands
| Description        | Command     |
|--------------------|:------------|
| List out all backup volumes | ```LIST BACKUPVOLUME``` | 
| List out data for a selected backup volume | ```LIST BACKUPVOLUME(*volume here*)``` | 
| List out all empty backup volumes | ```LIST BACKUPVOLUME SELECT(EMPTY)``` | 
| List out all disaster recovery migration tapes | ```HSEND LIST TTOC SELECT(DISASTERALTERNATEVOLUMES)``` | 
| List out the contents of a small dataset packing dataset on the specified volume | ```HSEND LIST DATASETNAME MIGRATIONCONTROLDATASET -SELECT(VOLUME(*volume here*) SDSP) ODS(*list.output.filename*)``` | 
| List out all migrated datasets with the specified high level qualifier | ```HSEND LIST LEVEL(*HLQ here*) MIGRATIONCONTROLDATASET ODS(*list.output.filename*)``` | 
| List out all the backups for files that match a partial dataset name |```HSEND LIST LEVEL(*partial.dsname*) BCDS ODS(*file.name*)``` | 
| List out all migrated datasets starting with RSJPROD that have not been referenced for less than 10 days, or more than 50 days | ```HLIST LEVEL(RSJPROD) SELECT(AGE(10 50)) MCDS TERM``` | 
| List out all the files that were on a primary volume last time it was backed up | ```HSEND LIST PVOL(*volume here*) BCDS BACKUPCONTENTS ODS(*file.name*)``` | 
| List out DUMP objects | ```LIST DUMPCLASS(*class*) or LIST DUMPVOLUME(*volume here*)``` | 


## BACK UP commands
| Description        | Command     |
|--------------------|:------------|
| Manually backup a dataset | ```HBACK /``` | 
| Set up backup destination | ```BACKDS *file.name* TARGET(DISK) CC(REQUIRED LE)``` | 
| Restore a data set from the backup | ```HRECOVER / REPLACE``` | 
| Recover a file to a different name, and select a backup taken on a specific date | ```HSEND RECOVER *recovered.filename* NEWNAME(*recovered.filename.newname*) -DATE(99/11/16)``` | 
| Recover a file to a new name, and force it onto a non-SMS volume | ```HSEND RECOVER *recovered.filename* NEWNAME(*recovered.filename.newname*) -TOVOLUME(V00101) UNIT(3390) FORCENONSMS``` | 
| Delete ALL backups for the file |  ```HSEND WAIT BDELETE (*file.name*)``` | 

## MIGRATION commands
| Description        | Command     |
|--------------------|:------------|
| Migrate all data sets on the specified volume | `MIGRATE VOLUME(*volume_name* MIGRATE(0))` |
| Migrate specified data set directly to a migration level 2 volume | `MIGRATE DATASETNAME(USER01.TEST.JOB) MIGRATIONLEVEL2` |
| Remove all data sets from a primary volume | `MIGRATE VOLUME(ONVOL MIG(0)) CONVERT` |
| Moving data sets from a primary volume to another primary volume | `MIGRATE VOLUME(*primary_volume01* MIGRATE(0)) CONVERT(*primary_volume02*)` |
| Bring a data set back to primary disk | ```HRECALL /``` | 
| Bring a data set back to primary disk. VOLCOUNT(ANY) will make the file go multi-volume, and will use up to 59 volumes | ```HRECALL / DFDSSOPTION VOLCOUNT(ANY)``` | 
| Bring a data set back to primary disk. The FORCENONSMS option to make the recall go to an empty spare volume, but then you have to relocate the file later | ```HRECALL / FORCENONSMS UNIT(*unittype*) VOLUME(*volume here*)``` | 
| Delete a migrated data set without recalling the data | ```HDEL /``` | 
