# JCL job template for split a file in n files containing equal number of records

**This JCL job template allows to divide one large input dataset into a uniform subset of separate datasets.**

[Link to clone/download from the repository](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/Batch%20jobs%20(JCLs)/JCL%20job%20template%20for%20evenly%20dividing%20the%20dataset%20into%20parts/JCL%20job%20template%20for%20split%20a%20dataset%20by%20an%20equal%20number%20of%20records)

**Be sure to change the following settings before starting the job:**
* `#INPUT DATASET#` - Input dataset that contains a large number of records
* `#OUT01,OUT02,...,OUTnn#` - How many datasets do you want to divide input dataset?
* `//OUT01 DD DSN=#Output file01#` - Output file01

  `//OUT02 DD DSN=#Output file02#` - Output file02
 
  `//* ...`
  
  `//OUTnn DD DSN=#Output filenn#` - Output filenn
* `IFTHEN=(WHEN=INIT,BUILD=(1:1,8,ZD,DIV,#Set number of divided datasets#,` - Set number of divided datasets

```
//S1    EXEC  PGM=ICETOOL
//TOOLMSG   DD  SYSOUT=*
//DFSMSG    DD  SYSOUT=*
//IN DD DSN=#INPUT DATASET#
//T1 DD DSN=&&T1,UNIT=SYSDA,SPACE=(TRK,(1,1)),DISP=(,PASS)
//C1 DD DSN=&&C1,UNIT=SYSDA,SPACE=(TRK,(1,1)),DISP=(,PASS)
//CTL3CNTL DD *
  OUTFIL FNAMES=(#OUT01,OUT02,...,OUTnn#),
//    DD DSN=*.C1,VOL=REF=*.C1,DISP=(OLD,PASS)
//OUT01 DD DSN=#Output file01#
//OUT02 DD DSN=#Output file02#
//*     ...
//OUTnn DD DSN=#Output filenn#
//TOOLIN DD *
//* Get the record count.
COPY FROM(IN) USING(CTL1)
//* Generate:
//* SPLIT1R=x where x = count/nn.
//* nn is the number of output files.
COPY FROM(T1) TO(C1) USING(CTL2)
//* Use SPLIT1R=x to split records contiguously among
//* the nn output files.
COPY FROM(IN) USING(CTL3)
/*
//CTL1CNTL DD *
  OUTFIL FNAMES=T1,REMOVECC,NODETAIL,
    TRAILER1=(COUNT=(M11,LENGTH=8))
/*
//CTL2CNTL DD *
  OUTREC IFOUTLEN=80,
   IFTHEN=(WHEN=INIT,BUILD=(1:1,8,ZD,DIV,#Set number of divided datasets#,  
      TO=ZD,LENGTH=8)),
   IFTHEN=(WHEN=(1,8,ZD,GT,+0),
     BUILD=(2X,C'SPLIT1R=',1,8)),
   IFTHEN=(WHEN=NONE,
     BUILD=(2X,C'SPLIT1R=1'))
/*
```
