# How to create a User Catalog?
Specify values for `#vol`,`#unit` and `#catalog_name`; change `CYLINDERS` if needed.
```Haskell
//STEP1    EXEC   PGM=IDCAMS
//VOL1     DD     VOL=SER=#vol,UNIT=#unit,DISP=OLD
//SYSPRINT DD     SYSOUT=*
//SYSIN    DD     *
  DEFINE USERCATALOG    -
   (NAME(#catalog_name) -
    CYLINDERS(5 1)      -
    VOLUME(#vol)        -
    ICFCATALOG          -
    SHAREOPTIONS(3 4))  -
    DATA                -
      (CONTROLINTERVALSIZE(4096)) -
    INDEX               -
      (CONTROLINTERVALSIZE(2048))
/*
```