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
| Start CICS Address space | [link](./JCL/SCICSAS) |
| Enable file | [link](./JCL/ENCICSF) |
| Enable TDQ | [link](./JCL/ECICSTDQ) |
| Set CICS Transaction enabled | [link](./JCL/ENCICST) |
| Set CICS Program enabled | [link](./JCL/ENCICSP) |
| Open file | [link](./JCL/OPCICSF) |
| Open extrapartition TDQ | [link](./JCL/OCICSTDQ) |