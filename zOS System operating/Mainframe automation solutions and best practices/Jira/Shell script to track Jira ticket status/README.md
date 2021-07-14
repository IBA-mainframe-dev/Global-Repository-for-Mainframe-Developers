# Shell script to track Jira ticket status

## Description
- The **curlFunction** function sends a get request to get issue data in Jira and this data is stored in result.txt
- The functions **parsingFunctionFirstMethod** and **parsingFunctionSecondMethod** are parsing data functions (in different ways)
- The **sendMailToSlack** function sends a message about status change to the slack channel 
- The **sendMailToEmail** function sends an issue status change message to an email
- The **startApplication** function starts the application if the issue status changes
- An infinite loop is started that checks the status and takes action

## Examples for running the script:
### Slack
```sh
bash Script <baseJiraURL> <jiraUser> <jiraPassword> <issueID> <DirectoryForFile> slack <HookSlack>
```

<T01DWK7PKCY/B01D70VUBMH/BfjzoOeNm64NrtR6mLuVfLfe> part of hooks url passed as parameter 													

### Email
```sh
bash Script <baseJiraURL> <jiraUser> <jiraPassword> <issueID> <DirectoryForFile> email <EmailRecipient>
```

### Application
```sh
bash Script <baseJiraURL> <jiraUser> <jiraPassword> <issueID> <directoryForFile> app <NameScriptOrApplication>
```

```
baseJiraURL                       host name of the Jira server. For example: jira.test.by
JiraUser/JiraPassword		  auth information to connect to Jira
issueID                           key and number of the issue. For example: TEST-19
path                              path name where result.txt data stored
optionSendMail                    options: slack, email or app
```

[Link to shell script sources](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Jira/Shell%20script%20to%20track%20Jira%20ticket%20status/script.sh)

**`Script`**:

If needed, specify `**EMAIL ADDRESS**` and `**PASSWORD**` in the script

```sh
baseJiraURL=$1
jiraUser=$2
jiraPassword=$3
issueID=$4
path=$5
optionSendMail=$6
to=$7

from=**EMAIL ADDRESS**
emailPasswordForSendMail=**PASSWORD**

function curlFunction {
        curl -L -D- -u $jiraUser:$jiraPassword -X GET -H "X-Atlassian-Token: nocheck" https://$baseJiraURL/rest/api/2/issue/$issueID?fields=status > /$path/result.txt
        value=`cat result.txt`
}

function parsingFunctionFirstMethod {
        value=`echo $value | sed 's/ /№/g'`
        my_arr=($(echo $value | tr "," "\n"))
        IFS='"' read -ra my_arr <<< "${my_arr[22]}"
        a=`echo "${my_arr[3]}"`
        status=`echo "${my_arr[3]}" | sed 's/№/ /g'`
}

function parsingFunctionSecondMethod {
        if grep -q "To Do" <<< "$value"; then
                status="To Do"
        elif grep -q "In Progress" <<< "$value"; then
                status="In Progress"
        elif grep -q "Done" <<< "$value"; then
                status="Done"
        fi
}

function sendMailToSlack {
        curl -X POST -H 'Content-type:application/json' --data "{\"text\":\"$msg\"}" https://hooks.slack.com/services/$to
}

function sendMailToEmail {
        {
                echo "From: \"Bot\" $from"
                echo "To: \"Alex\" $to"
                echo "Subject: Status has been changed"
                echo
                echo "$msg"
        } > mail.txt
        curl --ssl-reqd --url 'smtps://smtp.gmail.com:465' --user "$from:$emailPasswordForSendMail" --mail-from "$from" --mail-rcpt "$to" --upload-file mail.txt --insecure

}

function startApplication {
        echo `bash "$to" "$msg"`

	# Also it's possible to start different applications
	# `libreoffice --writer`
}

for((;;))
do
        curlFunction
        parsingFunctionSecondMethod
        previosSt="$status"

        sleep 10

        curlFunction
        parsingFunctionSecondMethod

        if [[ "$previosSt" != "$status" ]]; then
                msg="Status of $issueID ticket was changed from '$previosSt' to '$status'"
                # echo "$msg"
                if [[ "$optionSendMail" == slack ]]; then
                        sendMailToSlack
                elif [[ "$optionSendMail" == email ]]; then
                        sendMailToEmail
                elif [[ "$optionSendMail" == app ]]; then
                        startApplication
                fi
        fi
done

```