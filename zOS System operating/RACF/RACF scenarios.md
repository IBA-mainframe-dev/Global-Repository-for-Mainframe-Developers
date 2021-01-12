# This document contains various day-to-day and rare RACF scenarios.

* [How to protect a data set?](#how-to-protect-a-data-set)
  * [Define a discrete data set profile](#define-a-discrete-data-set-profile)
  * [Define a fully qualified generic data set profile](#define-a-fully-qualified-generic-data-set-profile)
* [How to protect multiple data sets?](#how-to-protect-multiple-data-sets)
* [How to remove protection from a data set?](#how-to-remove-protection-from-a-data-set)
* [How to permit user or group to use a data set?](#how-to-permit-user-or-group-to-use-a-data-set)
* [How to deny user or group to use a data set?](#how-to-deny-user-or-group-to-use-a-data-set)
  * [Remove userid from the access list](#remove-userid-from-the-access-list)
  * [Change the user access level to NONE](#change-the-user-access-level-to-none)
* [How to change a data set's Universal Access Authority (UACC)?](#how-to-change-a-data-sets-universal-access-authority-uacc)
* [How is the data set protected?](#how-is-the-data-set-protected)
* [How to recover locked TSO user?](#how-to-recover-locked-tso-user)
* [How to control the use of a command?](#how-to-control-the-use-of-a-command)

___

## How to protect a data set?
Suppose you have a data set that you would like to restrict access to (Universal Access ```UACC``` - NONE). You can choose between discrete and fully qualified data set profiles. The data set profile name must be the same as the name of the data set itself. For instance, `'userid-or-groupid.SAMPLE.DATASET'`

First, [find out if this data set is already protected](#how-is-the-data-set-protected)

### Define a discrete data set profile
*Note: If the data set is deleted, the data set profile will be deleted along with it.*

If the data set is cataloged:
```ruby
AD 'userid-or-groupid.SAMPLE.DATASET' UACC(NONE)
```
If uncataloged, you must specify `UNIT`(for example, SYSDA) and `VOLUME`(for example, MYVOL1):
```ruby
AD 'userid-or-groupid.SAMPLE.DATASET' UACC(NONE) UNIT(SYSDA) VOLUME(MYVOL1)
```
Changes take effect immediately

### Define a fully qualified generic data set profile

*Note: If the data set is deleted, the data set profile will remain in the system*
```ruby
AD 'userid-or-groupid.SAMPLE.DATASET' UACC(NONE) GEN
```
Changes take effect after one of the events:
* the user issues `LD ('userid-or-groupid.SAMPLE.DATASET') GEN`
* the user logs off and then logs back on
* `SETROPTS GENERIC(DATASET) REFRESH` is issued on the system

## How to protect multiple data sets?

Suppose you want to protect a group of data sets with similar names. For instance, ```'userid-or-groupid.PROJECT. *'```.

First, [find out if this data set is already protected](#how-is-the-data-set-protected)

```ruby
AD 'userid-or-groupid.PROJECT.*' UACC(NONE)
```
Changes take effect after one of the events:
* the user issues `LD ('userid-or-groupid.PROJECT.*') GEN`
* the user logs off and then logs back on
* `SETROPTS GENERIC(DATASET) REFRESH` is issued on the system


## How to remove protection from a data set?

First, [find out what profile protects the data set](#how-is-the-data-set-protected)

There are several options:

* Remove the profile that protects the data set
```ruby
DD 'profile-name'
```
* If the data set is protected by a generic profile, but protection is no longer needed - rename the data set
* You can [change UAСС](#how-to-change-a-data-sets-universal-access-authority-uacc) to ALTER. Then the profile will remain, but the protection will not work

## How to permit user or group to use a data set?

Suppose you have a data set profile and you want to give a user or a group an access `level`.

```ruby
PE 'profile-name' ID(user-or-groupid,...) AC(level) {GEN}
```
For instance, group data set 'USRGRP01.PROJECT.ONE' is protected by a discrete profile. To allow user JAMES and group USRGRP2 to update the data set, enter:
```ruby
PE 'USRGRP1.PROJECT.ONE' ID(USRGRP2,JAMES) AC(UPDATE)
```
If you want to give access to the profile to all RACF defined users, enter:
```ruby
PE 'USRGRP1.PROJECT.ONE' ID(*) AC(UPDATE)
```
Changes take effect after one of the events:
* the user logs off and then logs back on
* `SETROPTS GENERIC(DATASET) REFRESH` is issued on the system

## How to deny user or group to use a data set?

*Note: if a generic data set profile is applied to a data set, but it does not meet security requirements, it makes sense to create a separate profile for the data set*

### Remove userid from the access list

One way is to remove `userid` from the access list. In case `UACC` is equal to READ or higher the user or group will be able to access the data set.
```ruby
PE 'profile-name' ID(user-or-group-id,...) DELETE {GEN}
```
Suppose you have a generic profile `'JAMES.PROJECT.*'` and you want to remove the userid JACK from the access list:
```ruby
PE 'JAMES.PROJECT.*' ID(JACK) DELETE GEN
```

### Change the user access level to `NONE`

Another way is to include the user or group on the access list with `ACCESS(NONE)`. Then the user will not be able to use the dataset anyway
```ruby
PE 'profile-name' ID(user-or-group-id,...) AC(NONE)
```
Suppose you have a discrete profile `'JAMES.PROJECT.ONE'` and you want to be sure that the group SALEGRP cannot use this data set:
```ruby
PE 'JAMES.PROJECT.ONE' ID(SALEGRP) AC(NONE)
```

## How to change a data set's Universal Access Authority (UACC)?

First, [find out what profile protects the data set](#how-is-the-data-set-protected)

Then change the profile's UACC to the required security `level` (*NONE, READ, UPDATE, CONTROL, ALTER, EXECUTE*)
```ruby
ALD 'profile-name' UACC(level) {GEN}
```

## How is the data set protected?

This command will help you understand if there is a data set profile protecting the data set

```ruby
for discrete:
LD DA('dataset-name') ALL

for generic:
LD DA('dataset-name') ALL GEN
```

## How to recover locked TSO user?
Suppose the user has forgotten the password and exceeded the set number of password attempts. To restore the user, enter the following command
```ruby
alu #user_name password(#new_pass) resume
```
Specify values for **#user_name** and **#new_pass**

## How to control the use of a command?

To control the use of a command, you need to know the `profile-name` that is responsible for it. It is usually written in the format: `subsystem-name.command.[qualifier]`
* `subsystem-name` - is the name of processing environment
* `command` - is the name of the command
* `qualifier` - is the type of object the command specifies (JOB or SYS, for example) or an operand of the command (LIST, for example)

MVS commands and required access level are presented here [MVS Commands, RACF Access Authorities, and Resource Names](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.ieag100/mvsracf.htm)

Suppose you want to restrict the use of the MVS `DISPLAY TCPIP`command. According to [MVS Commands, RACF Access Authorities, and Resource Names](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.ieag100/mvsracf.htm), the `DISPLAY TCPIP` command require READ access. Let's set UACC to NONE and give the ADMINGRP group privilege to use the command.

```
SETROPTS GENERIC(OPERCMDS) REFRESH

/* If you are defining a resource from scratch, use RDEF,
but if the resource is already defined in the OPERCMDS class,
you must use RALT */
RALT OPERCMDS MVS.DISPLAY.TCPIP UACC(NONE)

PE MVS.DISPLAY.TCPIP CL(OPERCMDS) ID(ADMINGRP) AC(READ)

SETROPTS CLASSACT(OPERCMDS)
SETROPTS RACLIST(OPERCMDS) REFRESH
SETROPTS GENERIC(OPERCMDS) REFRESH
```
If you would like to view the contents of the profile, enter `RL OPERCMDS MVS.DISPLAY.TCPIP`
