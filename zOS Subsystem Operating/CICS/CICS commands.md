# This document contains day-to-day CICS subsystem commands

**Through CICS console**:

Specify `@{ variable }`

| Description       | Command          |
|-------------------|:-----------------|
| Enable file | `CEMT SET FILE(@{CICS_FILE}) ENABLED`  |
| Enable TDQ  | `CEMT SET TDQ(@{CICS_TDQ}) ENABLED` |
| Enable transaction | `CEMT SET TRANSACTION(@{CICS_TRANSACTION}) ENABLED` |
| Enable program  | `CEMT SET PROGRAM(@{CICS_PROGRAM}) ENABLED` |
| Open file | `CEMT SET FILE(@{CICS_FILE}) OPEN` |
| Open TDQ | `CEMT SET TDQ(@{CICS_TDQ}) OPEN` |

**Through JCL jobs**:

Specify `@{ variable }`

| Description       | Link          |
|-------------------|:-----------------|
| Start CICS Address space | [link](./JCL/Start%20CICS%20Address%20space.md) |
| Enable file | [link](./JCL/Enable%20file.md) |
| Enable TDQ | [link](./JCL/Enable%20TDQ.md) |
| Set CICS Transaction enabled | [link](./JCL/Set%20CICS%20Transaction%20enabled.md) |
| Set CICS Program enabled | [link](./JCL/Set%20CICS%20Program%20enabled.md) |
| Open file | [link](./JCL/Open%20file.md) |
| Open extrapartition TDQ | [link](./JCL/Open%20extrapartition%20TDQ.md) |