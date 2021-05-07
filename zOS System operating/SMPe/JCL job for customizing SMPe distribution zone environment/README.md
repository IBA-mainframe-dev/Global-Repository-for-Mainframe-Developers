# JCL job to customize SMP/e distribution zone environment

**`CUSTDST` - This JCL job is used to customize SMPe distribution zone environment**

[**Link to clone/download from the repository**](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/SMPe/JCL%20job%20for%20customizing%20SMPe%20distribution%20zone%20environment/CUSTDST)

```
//CUSTDST  JOB <JOB PARAMETERS>
//******************************************************//
//*  THIS JOB IS USED TO CUSTOMIZE                     *//
//*  SMP/E DISTRIBUTION ZONE ENVIRONMENT               *//
//*                                                    *//
//*  INSTRUCTIONS:                                     *//
//*  1. CHANGE SMPEHLQ TO THE HLQ YOU NEED             *//
//*  2. REPLACE USERHLQ WITH SMPEHLQ VALUE             *//
//*  3. REPLACE USERLIB1,2.. WITH LIB NAME YOU NEED    *//
//*  4. REPLACE XXXXXX IN ZONEDESCRIPTION(XXXXXX)      *//
//*     WITH YOUR DESCRIPTION                          *//
//*  5. REPLACE XXX IN OPTIONS(XXX) WITH YOUR OPTIONS  *//
//*     NAME                                           *//
//******************************************************//
//       SET SMPEHLQ='#SMPE HLQ#'
//******************************************************//
//UPDDLIB EXEC PGM=GIMSMP,
// PARM='DATE=U',REGION=8M
//SMPLOG DD DISP=MOD,DSN=&SMPEHLQ..SMPLOG
//SMPLOGA DD DISP=MOD,DSN=&SMPEHLQ..SMPLOGA
//SMPRPT DD SYSOUT=*
//SMPCSI DD DSN=&SMPEHLQ..GB.CSI,DISP=SHR
//******************************************************//
//SMPCNTL DD *
  SET BOUNDARY(DZONE) .
  UCLIN.
   ADD DLIBZONE(DZONE)
       SREL(Z038)
       OPTIONS(XXX)
       RELATED(TZONE)
       ZONEDESCRIPTION(XXXXXX)
   .
   ADD DDDEF(SMPTLIB)
       UNIT(SYSDA)
   .
   ADD DDDEF(SMPLOG) MOD DA(USERHLQ.SMPLOG)
   .
   ADD DDDEF(SMPLOGA) MOD DA(USERHLQ.SMPLOGA)
   .
   ADD DDDEF(SMPPTS) SHR DA(USERHLQ.SMPPTS)
   .
   ADD DDDEF(SMPSTS) SHR DA(USERHLQ.SMPSTS)
   .
   ADD DDDEF(SMPMTS) SHR DA(USERHLQ.SMPMTS)
   .
   ADD DDDEF(SMPSCDS) SHR DA(USERHLQ.SMPSCDS)
   .
   ADD DDDEF(MACLIB) SHR DA(SYS1.MACLIB)
   .
   ADD DDDEF(SYSLIB) CONCAT(MACLIB)
   .
   ADD DDDEF(SMPOUT) SYSOUT(*)
   .
   ADD DDDEF(SYSPRINT) SYSOUT(*)
   .
   ADD DDDEF(SMPLIST) SYSOUT(*)
   .
   ADD DDDEF(SMPRPT) SYSOUT(*)
   .
   ADD DDDEF(SMPSNAP) SYSOUT(*)
   .
   ADD DDDEF(SMPDEBUG) SYSOUT(*)
   .
   ADD DDDEF(SMPPUNCH) SYSOUT(B)
   .
   ADD DDDEF(SMPWRK1)
    BLK(6160) SPACE(230,380) DIR(111) NEW DELETE
    UNIT(SYSDA)
   .
   ADD DDDEF(SMPWRK2) BLK(6160) SPACE(300,400) DIR(111) NEW
    DELETE
    UNIT(SYSDA)
   .
   ADD DDDEF(SMPWRK3) BLK(3120) SPACE(400,500) DIR(111) NEW
    DELETE
    UNIT(SYSDA)
   .
   ADD DDDEF(SMPWRK4) BLK(3120) SPACE(400,500) DIR(111) NEW
    DELETE
    UNIT(SYSDA)
   .
   ADD DDDEF(SMPWRK6) BLK(6160) SPACE(300,400) DIR(111) NEW
    DELETE
    UNIT(SYSDA)
   .
   ADD DDDEF(SYSUT1) BLK(6160) SPACE(300,800)
    UNIT(SYSDA)
   .
   ADD DDDEF(SYSUT2) BLK(6160) SPACE(300,800)
    UNIT(SYSDA)
   .
   ADD DDDEF(SYSUT3) BLK(6160) SPACE(300,800)
    UNIT(SYSDA)
   .
   ADD DDDEF(SYSUT4) BLK(6160) SPACE(300,800)
    UNIT(SYSDA)
   .
   ADD DDDEF(SYSPUNCH) BLK(6160) SPACE(300,400) DIR(91)
    UNIT(SYSDA)
   .
   ADD DDDEF(AUSRLIB1) SHR DA(USERHLQ.AUSRLIB1)
   .
   ADD DDDEF(AUSRLIB2) SHR DA(USERHLQ.AUSRLIB2)
   .
   ADD DDDEF(AUSRLIB3) SHR DA(USERHLQ.AUSRLIB3)
   .
   ENDUCL.
/*
```