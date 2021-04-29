# How do I dynamically authorize a library (APF)?

To authorize a library use the following commands from SDSF:

1. For open “System Command Extension” use:   `/+` 

<img src="https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/images/sdsf-command-extension.png">

Now a very long command can be entered. It is useful if the library name is too long.

2. `SETPROG APF,add,library=LIBNAME.QA.MODL,volume=VOLNAME`
