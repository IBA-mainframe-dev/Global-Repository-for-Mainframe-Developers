# This document contains various day-to-day and rare ISPF commands.

## How to find a string

| Command | Description | 
|---------|:------------|
|Find string |```F Str```  |
|Change all strings to another|```F Str NEXT``` |
|Find string (previous match)|```F Str PREV``` |
|Find string (first match) |```F Str FIRST```  |
|Find string (last match)|```F Str LAST``` |
|Find string (all matches)|```F Str ALL``` |

## How to change a string

| Command | Description | 
|---------|:------------|
|Change string Str1 to string Str2  |```C Str1 Str2```	 |
|Change all strings Str1 to another strings Str2|```C ALL Str1 Str2```  |
|Repeat the action of the previous CHANGE command (change one character string to another) (Edit and View only)|```RCHANGE``` |

## How to create a member

| Command | Description | 
|---------|:------------|
|Create another member from the one you are editing| ```CRE MEMBER_NAME``` |

## Dataset management

| Command | Description | 
|---------|:------------|
|Refresh a data-list. You can try this command for inside a PDS, PDS member, PS file, Dataset list etc.|```REF``` |
|Browse a file. Give ‘B’ in front of a dataset in DSLIST|```B``` |
|View a dataset. Give ‘V’ in front of a dataset in DSLIST|```V``` |
|Edit a dataset. Give ‘E’ in front of a dataset in DSLIST.|```E``` |
|Delete the lines from the files you are editing |```DEL```  |
|Cancel changes made to the dataset|```CANCEL``` |
|Scroll to the bottom of the data| ```BOTTOM``` |

## Switch to utilities or other workplaces

| Command | Description | 
|---------|:------------|
|Invoke the ISPF DTL Conversion Utility|```ISPDTLC``` |
|Start the ISPF Workplace|```ISPFWORK``` |
|Invoke the LIBDEF Display Utility|```ISPLIBD``` |
|Create preprocessed panels, those for which ISPF has partially processed the panel definition before it is stored in the panel data set, either interactively or in batch mode|```ISPPREP``` |

## Info

| Command | Description | 
|---------|:------------|
|Change the default colors on seven-color display devices.|```COLOR``` |
|Provide general information about the contents of a panel|```XHELP``` |
|Display the PF Key Definitions. Change the ZPF variable settings (ZPFVARs).|```KEYS``` |



