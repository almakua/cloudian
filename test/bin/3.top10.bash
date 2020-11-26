#!/bin/bash
# this script will output the top 10 used words in the data column

# Variables
DATADIR="${PWD}/data"
BINDIR="${PWD}/bin"
TMPDIR="${PWD}/.tmp"
ZIPDIR="${PWD}/zip"
ARCHIVE="${PWD}/archive"

# initialize the file, and give it a bit of context by naming the columns
echo "#occurr word" > ${DATADIR}/3.top10.dat
echo >> ${DATADIR}/3.top10.dat

# a bit of concatenation to achieve the desired result. We get this way the top 10 used words
cut -d\| -f5 ${DATADIR}/1.output.log | tr ' ' '\n' | tr '[:punct:]' '\n' | egrep [a-z,A-Z] | grep -v [0-9]| sort | uniq -c | sort -rn | head -10 >> ${DATADIR}/3.top10.dat

# everyone loves compression, especially at PiedPiper
tar cvzf ${ZIPDIR}/3.top10.dat.tgz --directory=${DATADIR} 3.top10.dat 2>&1 > /dev/null