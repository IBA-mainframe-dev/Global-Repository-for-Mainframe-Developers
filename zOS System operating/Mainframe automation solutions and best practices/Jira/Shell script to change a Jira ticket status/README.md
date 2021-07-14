# Shell script to change a Jira ticket status

`changeJiraTicketStatus.sh` is intended to change status to a Jira issue.

Please, make sure that the user has all the required access.

**Instructions:**

Execution format::
```
>./changeJiraTicketStatus.sh [baseJiraURL] [issueID] [newStatus] [JiraUser] [JiraPassword]
```

```
baseJiraURL                       host name of the Jira server. For example: jira.test.by
issueID                           key and number of the issue. For  example: TEST-17
newStatus                         ID of new status (in different Jira’s ID’s differ)
JiraUser/JiraPassword		      auth information to connect to Jira
```

Example:
```
>./changeJiraTicketStatus.sh jira.test.by TEST-17 31 jiraUser JiraPwd
```

[Link to shell script sources (changeJiraTicketStatus.sh)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Jira/Shell%20script%20to%20change%20a%20Jira%20ticket%20status/changeJiraTicketStatus.sh)

**`changeJiraTicketStatus.sh`**
```sh
echo "reading input parameters"
baseJiraURL=$1
issueID=$2
newStatus=$3
JiraUser=$4
JiraPassword=$5
resolvedStatus='{"transition": { "id": "'${newStatus}'" } }'

echo "baseJiraURL=${baseJiraURL}"
echo "issueID=${issueID}"

curl -L  --post301 -D- -u ${JiraUser}:${JiraPassword} -X POST --data "${resolvedStatus}" -H "Content-Type: application/json" http://${baseJiraURL}/rest/api/2/issue/${issueID}/transitions
```

## Example: Сhange Jira ticket status from `TO DO` to `IN PROGRESS`

The ID of each status, including the custom one, can be determined by viewing the html code of the Jira ticket page when selecting statuses. Because in different Jira’s ID’s differ, including for standard statuses. This is the fastest way to find them.

![ web developer console ](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/images/jira_ticket_statuses.png)

We can save them in advance because they don't change:
```
def transitionToDo       = [ transition: [ id: '11' ] ] 
def transitionInProgress = [ transition: [ id: '21' ] ]
def transitionDone       = [ transition: [ id: '31' ] ]
```
To change a ticket status from `TO DO` to `IN PROGRESS`
```
>./changeJiraTicketStatus.sh jira.test.by TEST-17 21 jiraUser JiraPwd
```