# This document contains day-to-day TSO commands

* [`ALLOCATE` a data set](#allocate-a-data-set)
* [`ATTRIB` for an `ALLOCATE` command](#attrib-for-an-allocate-command)
* [Release a previously allocated data set](#release-a-previously-allocated-data-set)
* [`SMCOPY` a data set](#smcopy-a-data-set)
* [`RENAME` a data set](#rename-a-data-set)
* [`DELETE` a data set or a data set member](#delete-a-data-set-or-a-data-set-member)
* [Display current job status of jobs that you have submitted](#display-current-job-status-of-jobs-that-you-have-submitted)
* [View the version of the system software](#view-the-version-of-the-system-software)
* [Concatenate dataset to a SYSPROC ddname](#concatenate-dataset-to-a-sysproc-ddname)
* [Display the dataset names and ddnames currently in use in your TSO session](#display-the-dataset-names-and-ddnames-currently-in-use-in-your-tso-session)
* [`CANCEL` a job](#cancel-a-job)

<div align="right">For more information, see <a href="https://www.ibm.com/docs/en/zos/2.1.0?topic=tsoe-zos-command-reference">z/OS TSO/E Command Reference</a></div>

___

## `ALLOCATE` a data set

The `ALLOCATE` command can be used to allocate PDS, PDS member, GDG, temporary data set, similar new dataset, PS, PDS/E, etc. 

Examples:
 
**Creating PDS with following parameters**
* Record length: 80
* Record format: Fixed
* Space: 2 cylinder for both primary and secondary allocation
* Directory blocks: 10
```haskell
ALLOCATE DATASET(#dsname) NEW DIR(10) CYLINDERS SPACE(2,2) DSORG(PO) RECFM(F) LRECL(80) BLKSIZE(80) CATALOG
```
To allocate **PDSE** specify `DSNTYPE(LIBRARY)`. We don't have to specify `DIR` here. Anyway, it's PDSE. The system will ignore it.
```haskell
ALLOCATE DATASET(#dsname) NEW CYLINDERS SPACE(2,2) DSORG(PO) DSNTYPE(LIBRARY) RECFM(F) LRECL(80) BLKSIZE(80) CATALOG
```

**Creating PS with following parameters**
* Record length: 80
* Record format: Fixed Blocked
* Space: 2 cylinder for both primary and secondary allocation
```haskell
ALLOC DA(#dsname) DSORG(PS) SPACE(2,2) TRACKS LRECL(80) BLKSIZE(800) RECFM(F,B) NEW
```
**Creating a data set using `LIKE`**

Allocate a new file #dsname2 which has similar properties as the file #dsname1 with a different space parameter which is 4 for primary and 2 for secondary (overriding some parameters).
```haskell
ALLOC DA(#dsname2) SPACE(4,2) TRACKS LIKE(#dsname1)
```

## `ATTRIB` for an `ALLOCATE` command
`ATTRIB` specifies a list of attributes. So then we can use it for a data set allocation. List remains for the duration of the TSO session or  until explicitly released with [FREE](#release-a-previously-allocated-data-set) command.
```haskell
ATTRIB TESTATTR LRECL(80) BLKSIZE(80) RECFM(F) DSORG(PO) 
```
```haskell
ALLOC DA(#dsname) USING(TESTATTR) NEW CYLINDERS SPACE(2,2) DSNTYPE(LIBRARY) CATALOG
```
```haskell
FREE ATTRLIST(TESTATTR)
```

## `RENAME` a data set
```haskell
RENAME #old_name #new_name
```

## `DELETE` a data set or a data set member

To delete a data set with help of TSO command, type:
```haskell
TSO DELETE '#dsname'
```
The shorthand of `DELETE` is `DEL`.

*Note*: it's better to provide a data set name within the quotation mark **''**.

## `SMCOPY` a data set

You can copy a data set to either a new or existing data set

With `SMCOPY` we can copy:
* a PDS member into another PDS or PDS/E
```haskell
TSO SMC FDS(#pdsname1(#mem)) TDS(#pdsname2(#mem)) NOTRANS
```
* a PDS member into a sequential data set
```haskell
TSO SMC FDS(#pdsname(#mem)) TDS(#sequential_data_set) NOTRANS
```
*Note*: you can specify the line numbers that interest you by adding the keyword `LINE(n:m)`, for instance, LINE(3:6) will copy 3, 4, 5, 6 records of a data set

## Display current job status of jobs that you have submitted
```haskell
STATUS
```

## View the version of the system software
```haskell
TSO ISPVCALL STATUS
```

## Concatenate dataset to a SYSPROC ddname
```haskell
ALLOC DDN(SYSPROC) SHR REUSE DSN('#dsname')
```

## Release a previously allocated data set
```haskell
TSO FREE DA(#dsname)
```

## Display the dataset names and ddnames currently in use in your TSO session
```haskell
LISTALC STATUS HISTORY SYSNAMES
```

## `CANCEL` a job
* Cancel
```haskell
TSO CANCEL #job_name(#job_id)
```
* Cancel and discard the printed output
```haskell
TSO CANCEL #job_name(#job_id) PURGE
```
