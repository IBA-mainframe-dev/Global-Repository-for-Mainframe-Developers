#!/bin/sh
#get variables values
VAR_PATH="/$PWD/#PATH TO CONFIG#/vardefs"
. "$VAR_PATH"

#get parameters
DSQ=$1
RESTORE=$2

path="$PWD"
TMPFILE=tmp.txt
SENDLIST=difflist.txt
GITDIFF=DIFF
#changesList.txt - saved list of modified modules  
CHANGESLIST=changesList.txt
rm $CHANGESLIST

if [ -z "$DSQ" ] || [ "$DSQ" = "restore" ]
 then
  echo Error: datasets qualifiers are not specified
  exit 1
fi
echo datasets qualifiers: $DSQ

#get list of changed modules from git
git diff --name-status origin/${masterBranch}...origin/${developBranch} > $GITDIFF

if [ ! -s "$GITDIFF" ]
 then
  echo Error: git diff did not find any changes. DIFF list is empty.
  exit 1
fi
echo ---------------
cat $GITDIFF
echo ---------------

if [ ! -z "$RESTORE" ] &&  [ "$RESTORE" = "restore" ]
 then
  echo restore changed modules from master branch
  path="$PWD"/master
else
  #add DIFF file in sendlist
  echo "$GITDIFF" >> $SENDLIST
fi

#read git diff file and create
# - DIFF file which will be send to z/OS
# - changesList.txt 
while read diffline
 do
   status=$(echo "$diffline" | awk '{print $1}')
   dataset=$(echo "$diffline" | awk '{print $2}')
   #if ZIGI is used for z/OS Git client:
   zigi=$(echo "$diffline" | grep -o "zigi")
   rename=$(echo "$status" | grep "R")
   if [ ! -z  "$rename" ]
   then
    dataset=$(echo "$diffline" | awk '{print $3}')
   fi

   if [ "$status" = "D" ] || [ ! -z "$zigi" ]
   then
	continue
   else
	echo "$dataset" >> $SENDLIST
        echo "$diffline" >> $CHANGESLIST
   fi
done < $GITDIFF

echo ---list to send------------
cat $SENDLIST
echo ---------------------------

#send to z/OS modules listed in SENDLIST
while read line
 do
    if [ ! -f "$path/$line" ]
    then
      echo Error: $path/$line does not exist
      res="error"
      continue
    else
      if echo "$line" | grep -q '/'
       then
    	 DIR=$(echo "$line" | cut -d "/" -f 1)
         MEMBER=$(echo "$line" | cut -d "/" -f 2)
         if echo "$MEMBER" | grep -q '.'
            then
                MEMBER=$(echo "$MEMBER" | cut -d "." -f 1)
         fi
         PARAMS='LR=80 BLOCKSIZE=32720 REC=FB TR PRI=10 SEC=100 DIR=20'
         echo  copy "$line" to z/OS
         echo "
          open ${HOST}
          quote USER ${USERID}
          quote PASS ${USERPSW}
          quote site $PARAMS
          mkdir '$DSQ.$DIR'
          cd '$DSQ.$DIR'
	  lcd $path
          put $line $MEMBER
          bye
         " | ftp -inv > $TMPFILE
         echo ---------------
         cat $TMPFILE
         echo ---------------
       else
	 PARAMS='LR=80 BLOCKSIZE=32720 REC=FB TR PRI=5 SEC=100'
         echo  copy "$line" dataset to z/OS
         echo "
           open ${HOST}
           quote USER ${USERID}
           quote PASS ${USERPSW}
           quote site $PARAMS
           put $path/$line '$DSQ.$line'
           bye
         " | ftp -inv > $TMPFILE
         echo ---------------
         cat $TMPFILE
         echo ---------------
       fi
    fi
    ERROR=$(grep -i 'Error' $TMPFILE)
    NOTCONN=$(grep -i 'Not connected' $TMPFILE)
    if [ -n "$ERROR" ] || [ -n "$NOTCONN" ]
     then
        echo Error occurred
        res="error"
    fi
done < $SENDLIST

rm $TMPFILE
rm $SENDLIST
rm $GITDIFF

if [ "$res" = "error" ]
then
  echo Sending files completed with errors
  exit 1
fi
