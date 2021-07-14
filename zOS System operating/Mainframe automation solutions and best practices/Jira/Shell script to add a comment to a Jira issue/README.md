# Shell script to add a comment to a Jira issue

`addCommentToJira.sh` is intended to add a comment to a Jira issue.

Please, make sure that the user has all the required access.

**Instructions:**

Execution format::
```
>./addCommentToJira.sh [baseJiraURL] [jiraProjectKey] [issueID] [comment] [JiraUser] [JiraPassword]
```
```
baseJiraURL                       host name of the Jira server. For example: jira.test.by
jiraProjectKey                    Jira project key. For example: TEST
issueID                           key and number of the issue. For example: TEST-19
comment                           comment Json format to be added to Jira issue. For example
				                  '{"body":"test comment"}'
JiraUser/JiraPassword		      auth information to connect to Jira
```

Example:
```
>./addCommentToJira.sh jira.test.by TEST TEST-19 '{"body":"test comment"}' jiraUser JiraPwd
```

[Link to shell script sources (addCommentToJira.sh)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Jira/Shell%20script%20to%20add%20a%20comment%20to%20a%20Jira%20issue/addCommentToJira.sh)

**`addCommentToJira.sh`**
```sh
echo "reading input parameters"
baseJiraURL=$1
jiraProjectKey=$2
issueID=$3
comment=$4
JiraUser=$5
JiraPassword=$6

PROJECT_PATH=${PWD}
mkdir -p  "${PROJECT_PATH}/$jiraProjectKey/$issueID"

echo "baseJiraURL=${baseJiraURL}"
echo "jiraProjectKey=${jiraProjectKey}"
echo "issueID=${issueID}"

curl -L  --post301 -D- -u ${JiraUser}:${JiraPassword}  -X POST  --data "${comment}"  -H "Content-type: application/json" -H "X-Atlassian-Token: nocheck" http://${baseJiraURL}/rest/api/2/issue/${issueID}/comment > ${PROJECT_PATH}/${jiraProjectKey}/${issueID}/comment.txt

cd "${PROJECT_PATH}/${jiraProjectKey}"
rm -r "${issueID}"
```
