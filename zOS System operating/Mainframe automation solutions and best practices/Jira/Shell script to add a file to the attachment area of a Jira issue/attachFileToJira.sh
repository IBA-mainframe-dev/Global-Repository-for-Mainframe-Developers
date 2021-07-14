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