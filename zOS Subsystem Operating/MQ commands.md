# This document contains various day-to-day and rare MQ commands.

## MQ control commands

### Multiplatform commands

| Description |Command| 
|---------|:------------|
| Create data conversion code from data type structures. |``` crtmqcvx ```|
| Create a queue manager. |``` crtmqm ```|
| Delete a queue manager. |``` dltmqm ```|
| Dump a list of current authorizations for a range of IBM MQ object types and profiles. |``` dmpmqaut ```|
| Use the dmpmqcfg command to dump the configuration of an IBM MQ queue manager. |``` dmpmqcfg ```|
| Display and format a portion of the IBM MQ system log. |``` dmpmqlog ```|
| Use the dmpmqmsg utility to copy or move the contents of a queue, or its messages, to a file. Formerly the IBM MQ qload utility. |``` dmpmqmsg ```|
| Display information about queue managers. |``` dspmq ```|
| Display the authorizations of a specific IBM MQ object. |``` dspmqaut ```|
| The status of a command server is displayed |``` dspmqcsv  ```|
| Display the file names corresponding to IBM MQ objects. |``` dspmqfls ```|
| Determine the route that a message has taken through a queue manager network. |``` dspmqrte ```|
| Use the dspmqspl command to display a list of all policies and details of a named policy. |``` dspmqspl ```|
| Display in-doubt and heuristically completed transactions. |``` dspmqtrn ```|
| Display IBM MQ version and build information. |``` dspmqver ```|
| Display information about the status of the mqweb server, or about the configuration of the mqweb server. The mqweb server is used to support the IBM MQ Console and administrative REST API. |``` dspmqweb ```|
| Stop the command server for a queue manager. |``` endmqcsv ```|
| End all listener process for a queue manager. |``` endmqlsr ```|
| Stop a queue manager or switch to a standby queue manager. |``` endmqm ```|
| End trace for some or all of the entities that are being traced. |``` endmqtrc ```|
| Stop the mqweb server that is used to support the IBM MQ Console and REST API. |``` endmqweb ```|
| Use the mqcertck command to diagnose potential TLS problems with your queue managers. |``` mqcertck ```|
| Display information about return codes and AMQ messages. |``` mqrc ```|
| Write the image of an object or group of objects to the log for media recovery. |``` rcdmqimg ```|
| Re-create an object, or group of objects, from their images contained in the log. |``` rcrmqobj ```|
| Resolve in-doubt and heuristically completed transactions. |``` rsvmqtrn ```|
| Obfuscate passwords in the .ini file used by the mqccred security exit. |``` runmqccred ```|
| Run a channel initiator process to automate starting channels. |``` runmqchi ```|
| Start a sender or requester channel. |``` runmqchl ```|
| Start the dead-letter queue handler to monitor and process messages on the dead-letter queue. |``` runmqdlq ```|
| Run a listener process to listen for remote requests on various communication protocols. |``` runmqlsr ```|
| Use the runmqras command to gather IBM MQ diagnostic information together into a single archive, for example to submit to IBM Support. |``` runmqras ```|
| Run IBM MQ commands on a queue manager. |``` runmqsc ```|
| Start the trigger monitor on a client. |``` runmqtmc ```|
| Start the trigger monitor on a server. |``` runmqtrm ```|
| Change the authorizations to a profile, object, or class of objects. Authorizations can be granted to, or revoked from, any number of principals or groups. |``` setmqaut ```|
| Enroll an IBM MQ production license. |``` setmqprd ```|
| Use the setmqspl command to define a new security policy, alter an already existing one, or remove an existing policy. |``` setmqspl ```|
| v9.2.0 - Configure the mqweb server. |``` setmqweb ```|
| Use the setmqxacred command to add or modify credentials in the IBM MQ XA credentials store. |``` setmqxacred ```|
| Migrate the persistent state of an IBM MQ publish/subscribe broker to a later version queue manager. |``` strmqbrk ```|
| Start the command server for a queue manager. |``` strmqcsv ```|
| Start a queue manager or ready it for standby operation. |``` strmqm ```|
| Enable trace at a specified level of detail, or report the level of tracing in effect. |``` strmqtrc ```|
| Start the mqweb server that is used to support the IBM MQ Console and REST API. |``` strmqweb ```|

### Windows commands

| Description |Command| 
|---------|:------------|
| Add IBM MQ configuration information. |``` addmqinf ```|
| Configure or control some Windows specific administrative tasks. |``` amqmdain ```|
| Create, check, and correct IBM MQ directories and files. |``` crtmqdir ```|
| Create a list of environment variables for an installation of IBM MQ |``` crtmqenv ```|
| Display IBM MQ configuration information |``` dspmqinf ```|
| v9.2.0 - Display installation entries from mqinst.ini and display license entitlement information. |``` dspmqinst ```|
| Stop the .NET monitor for a queue. |``` endmqdnm ```|
| End the IBM MQ service. |``` endmqsvc ```|
| The migmqlog command migrates logs, and can also change the type of your queue manager logs from linear to circular or from circular to linear. |``` migmqlog ```|
| Start IBM MQ Explorer (Windows and Linux x86-64 platforms only). |``` MQExplorer ```|
| Remove IBM MQ configuration information. |``` rmvmqinf ```|
| Start processing messages on a queue using the .NET monitor. |``` runmqdnm ```|
| Administer certificate revocation list (CRL) LDAP definitions in an Active Directory. |``` setmqcrl ```|
| Use the setmqenv command to set up the IBM MQ environment |``` setmqenv ```|
| Set IBM MQ installations. |``` setmqinst ```|
| Set the associated installation of a queue manager. |``` setmqm ```|
| Publish client connection channel definitions in an Active Directory. |``` setmqscp ```|
| Start IBM MQ Explorer (Windows and Linux x86-64 platforms only). |``` strmqcfg ```|
| Start the IBM MQ service. |``` strmqsvc ```|
