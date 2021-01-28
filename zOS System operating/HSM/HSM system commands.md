# This document contains useful day-to-day HSM system commands

## QUERY commands
| Description        | Command     |
|--------------------|:------------|
| List out running processes and the statuses of the HSM components | `QUERY ACTIVE` | 
| List out all waiting for resource commands | `QUERY WAITING` |
| List out what is happening with HSM's automatic functions | `QUERY AUTOPROGRESS` |
| List out the users who are running active or queued commands | `QUERY USER` |
| Query active processes | `QUERY PROCESS` |
| List out the name of the HSM started task | `QUERY IMAGE` |
| List out all automatic processes running at this time | `QUERY AUTOP` |
| List out all ABARS parameters | `QUERY ABARS` |
| List out all aggregate recovery volumes | `QUERY ARPOOL` |
| List out all the recall pools | `QUERY POOL` |
| List out all current backup parameters | `QUERY BACKUP` |
| List out CDS backup information | `QUERY CDSV` |
| List out information about the CDS files | `QUERY CDS` |
| List out ML2 volumes, including info about volumes that are currently in use | `QUERY ML2` |
| List out all HSM information for the specified dataset | `QUERY DATASETNAME(dataset.name)` |
| List out space information for a specified volume | `QUERY SPACE(volume_here)` |
| List out the HSM startup parameters | `QUERY STAR` |
| List out all files that are excluded from migration by SETMIG commands | `QUERY RETAIN` |
| List out the CSA or memory limit parameters for HSM | `QUERY CSALIMITS` |
| List out DFHSM settings | `QUERY SETSYS` |


## HOLD, RELEASE and CANCEL commands
| Description        | Command     |
|--------------------|:------------|
| Hold backup. Optionally (AUTO DCCOMMAND(TAPE) | `HOLD BACKUP` |
| Hold recall. Optionally (TAPE) | `HOLD RECALL` | 
| Hold migration | `HOLD MIGRATION` |
| Hold fast replication recover. Optionally (TAPE) | `HOLD FRRECOV` |
| Hold dump | `HOLD DUMP` |
| Hold aggregate backup | `HOLD ABACKUP` | 
| Hold aggregate recovery | `HOLD ARECOVER` |
| Hold tape recycling | `HOLD RECYCLE` |
| Hold tape copy | `HOLD TAPECOPY` |
| Hold tape replication | `HOLD TAPEREPL` |
| Hold common recall queue (CRQ) | `HOLD COMMONQUEUE` |
| Hold recover. Optionally (TAPEDATASET) | `HOLD RECOVER` |
| Release function | `RELEASE function_name` |
| Cancel request | `CANCEL REQUEST(request_number)` |
| Cancel all user processes | `CANCEL USER(userid)` |

