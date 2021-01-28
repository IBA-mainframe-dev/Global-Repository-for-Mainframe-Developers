#!/bin/sh
#echo reading input parameters
INPUTFILE=$1
DSQ=$2
echo Input jcl: $INPUTFILE
TMPFILE=tmp.txt

HOST=#Mainframe IP-address here#
USERID=#MF User#
PASSWD=#User password#
input="$PWD"

if [ ! -f "$INPUTFILE" ]
 then
  echo Error: Input file $INPUTFILE not found
  exit 1
fi

if [ -z "$DSQ" ]
 then
  echo use default qualifiers
  DSQ='USER01.TEST'
fi

echo datasets qualifiers: $DSQ

while read line
 do
    if [ -d "$input/$line" ]
    then
      PARAMS='LR=80 BLOCKSIZE=32720 REC=FB TR PRI=10 SEC=100 DIR=20'
      echo  copy "$line" lib to z/OS
      echo "
        open $HOST
        quote USER $USERID
        quote PASS $PASSWD
        quote site $PARAMS
        mkdir '$DSQ.$line'
        cd '$DSQ.$line'
        lcd $input/$line
        mput *
        ls
        bye
      " | ftp -inv > $TMPFILE
      echo ---------------
      cat $TMPFILE
      echo ---------------
    else
      if [ -f "$input/$line" ]
	 then
	    PARAMS='LR=80 BLOCKSIZE=32720 REC=FB TR PRI=5 SEC=100'
            echo  copy "$line" dataset to z/OS
            echo "
              open $HOST
              quote USER $USERID
              quote PASS $PASSWD
              quote site $PARAMS
              put $input/$line '$DSQ.$line'
              bye
            " | ftp -inv > $TMPFILE
            echo ---------------
            cat $TMPFILE
            echo ---------------
         else
            echo Error: $input/$line does not exist
	    res="error"
	    continue
      fi
    fi
    ERROR=$(grep -i 'Error' $TMPFILE)
    if [ -n "$ERROR" ]
     then
        echo Error occurred: $ERROR
        res="error"
    fi
done < $INPUTFILE

rm $TMPFILE

if [ "$res" = "error" ]
then
  echo Sending libs completed with errors 
  exit 1
fi