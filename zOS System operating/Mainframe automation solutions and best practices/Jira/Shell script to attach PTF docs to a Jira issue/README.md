# Shell script to attach PTF docs to a Jira issue

`attachPTFdocs.sh` is intended to fill Transmittal_note.txt with information(tool name, tool release, APARs, etc.) from Jira issue 
and to attach RCA.xlsx and Transmittal_note.txt for PTF to a Jira issue.

RCA.xlsx document is placed in the git repository Script, PTF_docs/<PTF name>.

Template for Transmittal_note.txt is placed in the PTF_docs/template. 

The script is to be used from Jenkins, connection to Git is to be opened with Jenkins plugin.

Please, make sure that the user has all the required access.

**Instructions:**

Execution format::
```
>./attachPTFdocs.sh [jiraID] [baseJiraURL] [JiraUser] [JiraPassword]
```
```
jiraID                            key and number ofthe issue. For  example: TEST-225
baseJiraURL                       host name of the Jira server. For example: jira.test.by
JiraUser/JiraPassword		  auth information to connect to Jira
```

Example:
```
>./attachPTFdocs.sh ${jiraID} ${BASE_JIRA_URL} $USERNAME $PASSWORD

>./attachPTFdocs.sh TEST-225 jira.test.by $USERNAME $PASSWORD
```

[Link to shell script sources (attachPTFdocs.sh)](https://github.com/IBA-mainframe-dev/Global-Repository-for-Mainframe-Developers/tree/master/zOS%20System%20operating/Mainframe%20automation%20solutions%20and%20best%20practices/Jira/Shell%20script%20to%20attach%20PTF%20docs%20to%20a%20Jira%20issue/attachPTFdocs.sh)

**`attachPTFdocs.sh`**
```sh
#!/bin/bash
jiraID=$1
baseJiraURL=$2
JiraUser=$3
JiraPassword=$4


#get variables values
VAR_PATH="/$PWD/script/config/vardefs"
. "$VAR_PATH"
echo $defaultHLQ
echo get zOs config file:
configFile=$defaultHLQ'.CONFIG(VARPROG)'
echo $configFile

DOC_PATH=script/PTF_docs
RCA=RCA.xlsx
TRNOTE=Transmittal_note.txt
TEMPLATE_PATH=script/PTF_docs/templates
CHANGESLIST=changesList.txt

TMPFILE=tmp.txt

echo "
open $HOST
quote USER $USERID
quote PASS $USERPSW
quote SITE FILE=SEQ
get '$configFile' $configFile
bye
" | ftp -nv > $TMPFILE

echo ---------------
cat $TMPFILE
echo ---------------

PTFNAME=$(grep 'PTFNAME' $configFile | sed -n -e 's/.*=//p')

rm $TMPFILE
rm $configFile

add_comment() {
	curl -L  --post301 -D- -u ${JiraUser}:${JiraPassword}  -X POST  --data "{\"body\":\"$1\"}"  -H "Content-type: application/json" -H "X-Atlassian-Token: nocheck" http://${baseJiraURL}/rest/api/2/issue/${jiraID}/comment
}

delete_attach(){
	curl -L --post301 -D- -u ${JiraUser}:${JiraPassword} -X GET -H "X-Atlassian-Token: nocheck"  http://${baseJiraURL}/rest/api/2/issue/${jiraID}/?fields=attachment > attach.txt
	DOCID=$(grep -o "\"id\":\"[0-9]*\",\"filename\":\"$1\"" attach.txt |grep -o [0-9]*)
	rm attach.txt
	if [ -z "$DOCID" ]
	then
		echo "There is no already attached $1"
	else
		echo "DOCID:" ${DOCID}
		curl -L --post301 -D- -u ${JiraUser}:${JiraPassword} -X DELETE -H "X-Atlassian-Token: nocheck"  http://${baseJiraURL}/rest/api/2/attachment/${DOCID}
	fi
}

attach_doc(){
        curl -L --post301 -D- -u ${JiraUser}:${JiraPassword} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@$1" http://${baseJiraURL}/rest/api/2/issue/${jiraID}/attachments
}

fill_trnote(){
cp $PWD/${TEMPLATE_PATH}/${TRNOTE} $PWD

curl -L --post301 -D- -u ${JiraUser}:${JiraPassword} -X GET -H "X-Atlassian-Token: nocheck"  http://${baseJiraURL}/rest/api/2/issue/${jiraID}/?fields=labels > ${TMPFILE}
label=$((grep -Po '(?<=(\"labels\":\[)).*(?=\])' ${TMPFILE})|tr '"' ' '|tr -d ' ')
IFS=',' read -r -a label_arr <<< "$label"

curl -L --post301 -D- -u ${JiraUser}:${JiraPassword} -X GET -H "X-Atlassian-Token: nocheck"  http://${baseJiraURL}/rest/api/2/issue/${jiraID}/?fields=fixVersions > ${TMPFILE}
fix_version=$(grep -Po '(?<=(\"name\":\")).*(?=\",)' ${TMPFILE})

rm ${TMPFILE}

modified=$((cat $PWD/${CHANGESLIST})|sed s'/^.//')
added=$((grep '^A' $PWD/${CHANGESLIST})|sed s'/^.//')
deleted=$((grep '^D' $PWD/${CHANGESLIST})|sed s'/^.//')
while read line
do
        case $line in
                *"Tool Name"*) echo $line ${label_arr[0]} >> ${TMPFILE};;
                *"Tool Release"*) echo $line ${fix_version} >> ${TMPFILE};;
                *"FMID"*) echo $line ${label_arr[1]} >> ${TMPFILE};;
                *"APAR"*) echo $line ${label_arr[2]} >> ${TMPFILE};;
                *"JIRA tickets"*) echo $line ${jiraID} >> ${TMPFILE};;
                *"List of fix related datasets"*) echo $line  >> ${TMPFILE}
                        if [ ! -z "$modified" ]
                        then
                                echo "$modified" >> ${TMPFILE}
                        fi
                        ;;
                *"New Part"*) echo $line >> ${TMPFILE}
                        if [ ! -z "$added" ]
                        then
                                echo "$added" >> ${TMPFILE}
                        fi
                        ;;
                *"Deleted Part"*) echo $line >> ${TMPFILE}
                        if [ ! -z "$deleted" ]
                        then
                                echo "$deleted" >> ${TMPFILE}
                        fi
                        ;;
                *) echo $line >> ${TMPFILE};;
        esac
done < ${TRNOTE}

cp $TMPFILE $TRNOTE
rm ${TMPFILE}
}



delete_attach ${TRNOTE}
fill_trnote
attach_doc $PWD/${TRNOTE}
add_comment "Transmittal note for PTF $PTFNAME was attached"

if [ -d "$PWD/$DOC_PATH/$PTFNAME" ]
then
        cd $PWD/$DOC_PATH/$PTFNAME
	if [ -f $RCA ]
	then
		delete_attach ${RCA}
		attach_doc $PWD/${RCA}
		add_comment "RCA document for PTF $PTFNAME was attached"
	else
		add_comment "There is no RCA document for PTF $PTFNAME to be attached to Jira ticket"
	fi
else
        add_comment "There are no existing documents for PTF $PTFNAME, nothing will be attached to Jira ticket"
fi
```
