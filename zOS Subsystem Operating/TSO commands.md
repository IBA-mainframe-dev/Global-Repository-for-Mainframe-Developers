# This document contains day-to-day TSO commands

* [`ALLOCATE` a data set](#allocate-a-data-set)
* [`SMCOPY` a data set](#smcopy-a-data-set)
* [`RENAME` a data set](#rename-a-data-set)
* [`DELETE` a data set or a data set member](#delete-a-data-set-or-a-data-set-member)
* [Display current job status of jobs that you have submitted](#display-current-job-status-of-jobs-that-you-have-submitted)
* [`CANCEL` a job](#cancel-a-job)
* [View the version of the system software](#view-the-version-of-the-system-software)
* [Concatenate dataset to a SYSPROC ddname](#concatenate-dataset-to-a-sysproc-ddname)
* [Display the dataset names and ddnames currently in use in your TSO session](#display-the-dataset-names-and-ddnames-currently-in-use-in-your-tso-session)
* [Remove the concatenation of a file from the allocation list](#remove-the-concatenation-of-a-file-from-the-allocation-list)

___

## `ALLOCATE` a data set

The `ALLOCATE` command is used for allocating a PS or PDS data set. `ALLOCATE` can be used for PDS, PDS member, GDG, temporary data set, similar new dataset, PS, PDS/E etc. 

Examples:
 
**Creating PDS with following parameters**
* Record length: 80
* Record format: Fixed
* Space: 2 cylinder for both primary and secondary allocation
* Directory blocks: 10
```haskell
ALLOCATE DATASET(#dsname) NEW DIR(10) CYLINDERS SPACE(2,2) DSORG(PO) RECFM(F) LRECL(80) BLKSIZE(80) CATALOG
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

## `CANCEL` a job
* Cancel
```haskell
TSO CANCEL #job_name(#job_id)
```
* Cancel and discard the printed output
```haskell
TSO CANCEL #job_name(#job_id) PURGE
```

## View the version of the system software
```haskell
TSO ISPVCALL STATUS
```

## Concatenate dataset to a SYSPROC ddname
```haskell
ALLOC DDN(SYSPROC) SHR REUSE DSN('#dsname')
```

## Remove the concatenation of a file from the allocation list
```haskell
TSO FREE DA(#dsname)
```

## Display the dataset names and ddnames currently in use in your TSO session
```haskell
LISTALC STATUS HISTORY SYSNAMES
```
