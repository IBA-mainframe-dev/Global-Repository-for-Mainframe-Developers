# Shell script to add a file to the attachment area of a Jira issue

`attachFileToJira.sh` is intended to add a file from the Linux machine to the attachment area of a Jira issue.

**Instructions:**

Execution format::
```
$ sh attachFileToJira.sh [baseJiraURL] [issueID] [pathToFile] [jiraUser] [jiraPassword]
```
```
baseJiraURL                       host name of the Jira server. For example: jira.test.by
issueID                           key and number ofthe issue. For  example: TEST-22
pathToFile                        absolute or relative path to the file on the machine to be sent to Jira.
jiraUser                          username to access to Jira
jiraPassword                      password to access to Jira 
                                  Do not use spaces in the file path
```

Example:
```
$ sh attachFileToJira.sh jira.test.by TEST-22 ..\README.txt
```

Output:

In the log you will recieve the response from Jira server with the response code and JSON object, that describes the attachment.

OK code is 200.

JSON object should be not empty.

[Link to shell script sources (attachFileToJira.sh)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Jira/Shell%20script%20to%20add%20a%20file%20to%20the%20attachment%20area%20of%20a%20Jira%20issue/attachFileToJira.sh)

**`attachFileToJira.sh`**
```sh
#! /bin/bash

echo reading parameters
baseJiraURL=$1
issueID=$2
pathToFile=$3
jiraUser=$4
jiraPassword=$5

echo $baseJiraURL
echo $issueID
echo $pathToFile

echo sending post request to jira to attach a file to the issue
# -L = redirection from IBM authoritation services
# --post301 = keep sending the same post request after each redirection
# -H "X-Atlassian-Token: nocheck" = to avoid Atlassian XSRF check failure

curl -L --post301 -D- -u $jiraUser:$jiraPassword -X POST -H "X-Atlassian-Token: nocheck" -F "file=@$pathToFile" http://$baseJiraURL/rest/api/2/issue/$issueID/attachments

```