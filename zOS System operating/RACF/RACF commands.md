# This document contains useful day-to-day RACF commands
[![HitCount](http://hits.dwyl.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers.svg)](http://hits.dwyl.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers)
## User Profiles
User profiles contain security information about the userid's defined to RACF who can access (or not) the resources.

| Description       | Command          |
|-------------------|:-----------------|
| Add a userid to the RACF database | ```AU userid NAME(‘user_name’) DFLTGRP(grp_name) OWNER(owner) PASS(password)``` |
| List a userid profile | ```LU userid``` |
| Set a temporary password to a userid | ```ALU userid PASSWORD(password)``` |
| Revoke a userid | ```ALU userid REVOKE``` |
| Resume a userid | ```ALU userid RESUME``` |
| Resume a userid and set a temporary password | ```ALU userid RESUME PASS(password)``` |
| Connect a userid to a RACF group | ```CO userid GROUP(grp_name) OWN(grp_name)``` |
| Remove a userid from a RACF group | ```RE userid GROUP(grp_name)``` |
| Change the user name of a userid | ```ALU userid NAME(‘user_name’)``` |
| Change the installation data of a userid | ```ALU userid DATA(‘inst_data’)``` |
| Delete a userid from RACF database | ```DU userid``` |

## Group Profiles
Group profiles contain security information about group attributes and user connections.

| Description       | Command          |
|-------------------|:-----------------|
| Add a group to RACF | ```AG grp_name OWNER(owner) SUPGROUP(superior_grp_name)``` | 
| List a RACF group details | ```LG grp_name``` | 
| Change the Superior Group of a RACF group | ```ALG grp_name SUPGROUP(superior_grp_name)``` | 
| Change installation data of a RACF group | ```ALG grp_name DATA(‘inst_data’)``` | 
| Delete a RACF group | ```DG grp_name``` | 

## Dataset Profiles
Dataset profiles contain security information about DASD and tape datasets.

| Description       | Command          |
|-------------------|:-----------------|
| Add a Dataset profile to RACF database | ```AD ‘ds_profile’ UACC(uacc_level)``` | 
| List a dataset profile details | ```LD DATASET(‘ds_profile’)``` | 
| Change a dataset profile UACC | ```ALD ‘ds_profile’ UACC(uacc_level)``` | 
| Change a dataset profile OWNER | ```ALD ‘ds_profile’ OWNER(owner)``` | 
| Delete dataset profile from RACF database | ```DD ‘ds_profile’``` | 
| List the profiles matching the mask argument and the Class | ```SR MASK(mask_argument) CLASS(class)``` | 
| Grants userid access to the dataset profile | ```PE ‘ds_profile’ ID(userid) GEN AC(access_level)``` | 
| Grants RACF group access to the dataset profile | ```PE ‘ds_profile’ ID(grp_name) GEN AC(access_level)``` | 

## General Resources
General resource profiles contain security information about all resources other than user, group or dataset.

| Command       | Description |
|---------------|:---------|
| Add a general resource profile | ```RDEF class_name profile_name ADDMEM(member)``` | 
| List all details of a general resource profile | ```RL class_name profile_name ALL``` | 
| Changes the general resource profile UACC | ```RALT class_name profile_name UACC(acc_level)``` | 
| Delete a general resource profile | ```RDEL class_name profile_name``` | 
| Grants userid access to the General resource profile of CL class | ```PE gr_profile CL(class) ID(userid) AC(access_level)``` | 
| Grants RACF group access to the General resource profile of CL class | ```PE gr_profile CL(class) ID(grp_name) AC(access_level)``` | 

## RACF Options
SETROPTS is used to set RACF options or to turn them off

| Description       | Command          |
|-------------------|:-----------------|
| Refresh in-storage profile for a specific CLASS | ```SETROPTS GENERIC(class_name) REFRESH``` | 
| Sets in RACF that all passwords must be at least six characters in length and contain at least one numeric character, not in the first or last position. Further, the user’s access to the system must be revoked if five incorrect passwords are entered in a row | ```SETROPTS PASSWORD(REVOKE(5) RULE1(LENGTH(6:8) ALPHA(1,6) ALPHANUM(2:5))``` <br> <br> ```RULE2(LENGTH(7) ALPHA(1,7) ALPHANUM(2:6))``` <br> <br> ```RULE3(LENGTH(8) ALPHA(1,8) ALPHANUM(2:7)))``` |
|Sets that all passwords must be changed within ```interval-days```, but not earlier than  ```minchange-days``` after the change.  RACF issue a warning message ```warning-days``` before a password expires|```SETROPTS PASSWORD(INTERVAL(interval-days) MINCHANGE(minchange-days) WARNING(warning-days))```|
|Sets the ```number-of-previous-passwords``` that RACF saves for each user and compares with intended new value|```SETROPTS PASSWORD(HISTORY(number-of-previous-passwords))```|
|Allow mixed-case passwords|```SETROPTS PASSWORD(MIXEDCASE)```|
|Revoke user's right to use the system if the user ID has remained unused within ```inactive-days```|```SETROPTS INACTIVE(inactive-days)```|
|Overwrite data with zeros after deletion|```SETROPTS ERASE```|
|Set RACF to overwrite all data sets at this ```security-level``` or higher after deletion|```SETROPTS ERASE SECLABEL(security-level)```|
|Deactivate erase-on-scratch processing|```SETROPTS NOERASE```|
|Bypass Automatic Data Set Protection(ADSP) - RACF does not automatically create discrete data set profiles when users who have the ADSP attribute create new data sets|```SETROPTS NOADSP```|
|Prevent users without the SPECIAL attribute from accessing uncataloged data sets|```SETROPTS CATDSNS```|








