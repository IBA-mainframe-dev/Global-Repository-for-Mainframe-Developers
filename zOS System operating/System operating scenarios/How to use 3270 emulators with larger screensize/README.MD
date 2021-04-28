# How to use 3270 emulators with larger screensize?

**Be careful**: This instruction is for the **IBM Personal Communications emulator**

1. Open ***.WS** file and update:
    * in [Telnet3270] section **add** 
    ```
    TerminalTypeString=IBM-DYNAMIC
    ```
        
    *  In [3270] section **modify**
    ```
    ScreenSize=43x142
    ```
2.	Run your session and enter ISPF
3.	Enter option Terminal and user parameters (option 0)
    *  Set Screen format   3 (Max)

![ispf-settings](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/System%20operating%20scenarios/How%20to%20use%203270%20emulators%20with%20larger%20screensize/images/ispf-settings.png)

4.	The screen should be 
![result](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/blob/master/zOS%20System%20operating/System%20operating%20scenarios/How%20to%20use%203270%20emulators%20with%20larger%20screensize/images/result.png)

