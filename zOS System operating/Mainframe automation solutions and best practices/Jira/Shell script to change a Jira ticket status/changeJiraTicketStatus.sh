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