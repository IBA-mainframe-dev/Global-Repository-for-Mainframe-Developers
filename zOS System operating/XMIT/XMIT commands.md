# This document contains various day-to-day and rare XMIT commands

## How to transmit a data set?
Specify `#node`, `#userid` and `#dsname`
```
TSO XMIT #node.#userid DSN('#dsname') OUTDSN('#dsname.XMIT')
```

**Or transmit members:**

Specify `#dsname`, `#mem_names`
```
TSO XMIT #node.#userid DSN('#dsname') MEMBERS(#mem_names) OUTDSN('#dsname.XMIT')
```

## How to receive a data set?

When you're receiving a data set, the system asks for additional parameters. Here you can specify `DA(name.of.your.library)`, `UNIT(unit)`, `VOLUME(volume)`. You can skip it if you want 

Specify `#dsname`
```
TSO RECEIVE INDSN('#dsname.XMIT')
```

## How to receive another user's data set?
You need to use `RECEIVE USER(#userid)` to specify whose files you want to
receive (and that's a restricted command - you need **OPER** authority to do
that)
```
TSO RECEIVE USER(#userid) INDSN('#dsname.XMIT')
```

## TRANSREC parameters

Check what class is used for the XMIT. Check the `SYS1.PARMLIB`
member `IKJTSO00` for any `TRANSREC` parameters, particularly SPOOLCL, which
defines the class for the outgoing data.

## Related topics

* [How to copy RTE to other LPAR?](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/System%20operating%20scenarios/How%20to%20copy%20RTE%20to%20other%20LPAR)