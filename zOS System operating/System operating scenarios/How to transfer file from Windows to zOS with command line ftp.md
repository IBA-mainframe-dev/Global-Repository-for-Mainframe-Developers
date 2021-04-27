# How to transfer file from Windows to zOS with command line ftp?

<p>To transfer files from Windows to z/OS (especially when z/OS file must be created with specific LRECL , RECFM, size, etc) - good way is to use <strong>ftp</strong> line command, entered in command prompt (Run-&gt;cmd ) window.</p>
<p>Below highlighted are few commands used to transfer character(not binary !) Windows file d:\downloads\USC.WRK.NOINTER.APFDBU.ACCESS2  to z/OS dataset USC.WRKTISH.NOINTER.APFDBU.ACCESS2</p>

<hr>
<p>C:\Users\shaklein_ia&gt;<strong>ftp stutvs13.megacenter.by.iba.com</strong><br>
Connected to STUTVS13.megacenter.by.iba.com.<br>
220-TCPFTPH1 IBM FTP CS V2R4 at STUTVS13.megacenter.by.iba.com, 09:03:04 on 2021-04-12.<br>
220 Connection will close if idle for more than 5 minutes.<br>
501 command OPTS aborted -- no options supported for UTF8<br>
User (STUTVS13.megacenter.by.iba.com:(none)): <strong>e544271</strong><br>
331 Send password please.<br>
Password: <strong><strong>_______</strong></strong><br>
230 E544271 is logged on.  Working directory is "E544271.".<br>
ftp&gt; <strong>ascii</strong><br>
200 Representation type is Ascii NonPrint<br>
ftp&gt; <strong>quote site lrecl=146 recfm=fb prim=20 sec=20 cyl</strong><br>
200-BLOCKSIZE must be a multiple of LRECL for RECFM FB<br>
200-BLOCKSIZE being set to 6132<br>
200 SITE command was accepted<br>
ftp&gt; <strong>put d:\downloads\USC.WRK.NOINTER.APFDBU.ACCESS2 'usc.wrktish.nointer.apfdbu.access2'</strong><br>
200 Port request OK.<br>
125 Storing data set USC.WRKTISH.NOINTER.APFDBU.ACCESS2<br>
250 Transfer completed successfully.<br>
ftp: 16364508 bytes sent in 8.56Seconds 1911.52Kbytes/sec.<br>
ftp&gt; <strong>quit</strong><br>
221 Quit command received. Goodbye.</p>
<hr>
