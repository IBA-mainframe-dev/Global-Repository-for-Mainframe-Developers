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