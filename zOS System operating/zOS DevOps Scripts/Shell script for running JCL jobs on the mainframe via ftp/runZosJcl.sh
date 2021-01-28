#!/bin/sh
HOST=#Mainframe IP-address here#
USERID=#MF User#
USERPSW=#User password#

echo reading input parameters
INPUTJOB=$1
OUTPUT=$2
echo JCL: $INPUTJOB
echo Output file: $OUTPUT

TMPFILE=tmp.txt

echo run JCL from z/OS
echo "
open ${HOST}
quote USER ${USERID}
quote PASS ${USERPSW}
quote SITE FILE=JES NOJESGETBYDSN
quote SITE JESOWNER=*
quote site jesjobname=*
get '$INPUTJOB' $OUTPUT
bye
" | ftp -nv > $TMPFILE

echo ---------------
cat $TMPFILE
echo ---------------

JOB_ID=$( grep -o "JOB[0-9][0-9]*" $TMPFILE | head -1 )
if [ -z "$JOB_ID" ]
then
   echo Error: job was not submitted
   exit 1
else
   echo Job $JOB_ID was submitted
fi
sleep 5s

echo check rc code
echo "
open ${HOST}
quote USER ${USERID}
quote PASS ${USERPSW}
quote site file=jes
quote site jesjobname=*
ls
bye
" | ftp -nv > $TMPFILE

#echo ---------------
#cat $TMPFILE
#echo ---------------

grep $JOB_ID $TMPFILE
RC_CODE=$(grep $JOB_ID $TMPFILE | grep -o "RC=[0-9]*")
if [ -n "$RC_CODE" ]
then
        RC_CODE=$(echo "$RC_CODE" | cut -d "=" -f 2)
fi
if [ -n "$RC_CODE" ] && [ "$RC_CODE" \< "0008" ]
then
        echo Job completed successfully
else
        echo Error: job failed
        res="failed"
fi
rm $TMPFILE

if [ "$res" = "failed" ]
then exit 1
fi