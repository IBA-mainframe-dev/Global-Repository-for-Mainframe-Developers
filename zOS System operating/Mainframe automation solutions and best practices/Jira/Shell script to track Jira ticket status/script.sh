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