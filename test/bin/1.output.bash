#!/bin/bash

# this will generate a random log file with the structure
# date|time|pid|status|data
# and it will right padded it with X so that each line is 500B (counting \n)

# Variables
DATADIR="${PWD}/data"
BINDIR="${PWD}/bin"
TMPDIR="${PWD}/.tmp"
ZIPDIR="${PWD}/zip"
#ARCHIVE="${PWD}/archive"


# download readable content from the provided page(s)
lynx -dump https://en.wikipedia.org/wiki/Amazon_S3 | egrep [a-z,A-Z] > ${TMPDIR}/awss3page.txt
sed -i -e 's/[ \t]*//' ${TMPDIR}/awss3page.txt

# we use a while loop just because. After initializing the counter, we let it go to the desired number
COUNTER=0

# body of the while loop
while [ $COUNTER -lt 10000 ]
do
    # bit of variable inizialization, as you can see, with some printf magic, and some shell built-in, we can obtain an estetically pleasing result
    DATE="20130101"
    TIME="$(printf "%02d" $(shuf -i9-11 -n1)):$(printf "%02d" $(shuf -i0-59 -n1)):$(printf "%02d" $(shuf -i0-59 -n1))"
    PID="$(shuf -i3000-5000 -n1)"
    STATUS="$(echo "OK TEMP PERM"|tr " " "\n"|sort -R|head -1)"
    RAND_LINE="$(shuf -n 9 ${TMPDIR}/awss3page.txt|tr -d '\n')"
    # we then print everything, while cutting the output at 499 chars 
    LOG_LINE="$(echo "$DATE|$TIME|$PID|$STATUS|$RAND_LINE|" tr -s " " | tr " " \} | head -c 499)"
    # finally we print the data after padding it with X
    printf "%-499s\n" "$LOG_LINE" | tr " " X | tr \} " " >> ${TMPDIR}/output.tmp
    # self explanatory
    let COUNTER=COUNTER+1 
done

# I wanted to have the logs correctly sorted by time 
sort ${TMPDIR}/output.tmp > ${DATADIR}/1.output.log

# everyone loves compression, especially at PiedPiper
tar cvfz ${ZIPDIR}/1.output.log.tgz --directory=${DATADIR} 1.output.log 2>&1 > /dev/null

# cleaning after yourself is a must have skill
rm ${TMPDIR}/*