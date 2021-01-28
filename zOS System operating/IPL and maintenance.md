# IPL and maintenance

To start initializing the system, enter from the console:
```haskell
IPL xxxx LOADPARM aaaabbcd
```
where 
* **xxxx** - device address from which to initialize the system (it is also called system residense volume - SYSRES)
* **аааа** - device address where the IODF config is located
* **bb**   - LOAD member number
* **c**    - IMSI (initialization message suppression indicator) - the prompting and message suppression characteristics
* **d**    - nucleus data set number - IEANUC0d и IEANUC2d

If the LOADPARM keyword is not specified, by default:
* the search for the IODF file will be performed on the SYSRES volume
* LOAD00 will be selected
* IMSI - blank - suppresses most informational messages and does not prompt for system parameters; will use the LOAD member values
* if NUCLEUS parameter is not specified in LOAD00, nucleus data set number - 1 (IEANUC01 и IEANUC21)

## LOADyy parameters

During IPL, the system looks for LOADyy member in the following order:
1. SYS0.IPLPARM through SYS9.IPLPARM on the IODF volume
2. SYS1.PARMLIB on the IODF volume
3. SYS1.PARMLIB on the SYSRES volume

LOAD contains many initialization parameters. As an example, a LOAD member might look like this:
```
IODF     00 SYS1                                            
SYSCAT   VOL001113CCATALOG.Z23D.MASTER                      
SYSPARM  AL                                                 
IEASYM   00                                                 
NUCLST   00                                                 
PARMLIB  DSN1.PARMLIB                                 VOL002
PARMLIB  DSN2.PARMLIB                                 VOL003
PARMLIB  SYS1.PARMLIB                                 VOL005
NUCLEUS  1                                                  
```
where
* `IODF` - **SYS1.IODF00** will be used as a configuration file
  * **SYS1** - high level qualifier
  * **00** - IODF id 
* `SYSCAT` - identifies the master catalog
* `SYSPARM` - identifies **IEASYSAL** member from PARMLIB concatenation.
* `IEASYM` - identifies **IEASYM00** member where static system symbols defined
* `NUCLST` - identifies **NUCLST00** that system will use
* `PARMLIB` - the following data sets will be included
  * `DSN1.PARMLIB`
  * `DSN2.PARMLIB`
  * `SYS1.PARMLIB` on VOL005
  * system automatically concatenates `SYS1.PARMLIB` from master catalog
* `NUCLEUS` - nucleus data set number - **IEANUC01** и **IEANUC21**

To display information about your system IPL, enter
```
/D IPLINFO
``` 
