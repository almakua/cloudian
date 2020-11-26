#!/bin/bash

# This script will handle the file configured, analized and for each minutes of the timeframe, it will print a csv with the corrispondent status, and a csv with all the statuses.
# Then it will graph it

# Variables
DATADIR="${PWD}/data"
BINDIR="${PWD}/bin"
TMPDIR="${PWD}/.tmp"
ZIPDIR="${PWD}/zip"
ARCHIVE="${PWD}/archive"


# variable to express the starting file
INPUT_FILE=${DATADIR}/1.output.log

# just a little bit of headers, so we can organize data better in graphs
echo "TIME,OK,TEMP,PERM" > ${DATADIR}/2.graph.csv
echo "TIME,OK" > ${DATADIR}/2.graphOK.csv
echo "TIME,TEMP" > ${DATADIR}/2.graphTEMP.csv
echo "TIME,PERM" > ${DATADIR}/2.graphPERM.csv


# now we cycle by hour, so we cover all the spectrum
for hour in $(seq 9 11)
do
    # then we cycle for each of the minutes in evey our, again, covering all the possibilities
    # for loop is better that looping date, because like this we can play with the output a bit better
    for minute in $(seq 0 59)
    do
        # variable-ize things so that everything is (kinda) readable
        # first grep by the time (with a little bit of printf magic so numbers are left padded with 0 if needed) then grep by each status
        OK="$(grep "$(printf "%02d" $hour):$(printf "%02d" $minute)" $INPUT_FILE | grep -c OK)"
        TEMP="$(grep "$(printf "%02d" $hour):$(printf "%02d" $minute)" $INPUT_FILE | grep -c TEMP)"
        PERM="$(grep "$(printf "%02d" $hour):$(printf "%02d" $minute)" $INPUT_FILE | grep -c PERM)"
        # now print like there is no tomorrow, again as before a bit of printf magic. WHOOOSH
        echo "$(printf "%02d" $hour):$(printf "%02d" $minute)","$OK" >> ${DATADIR}/2.graphOK.csv
        echo "$(printf "%02d" $hour):$(printf "%02d" $minute)","$TEMP" >> ${DATADIR}/2.graphTEMP.csv
        echo "$(printf "%02d" $hour):$(printf "%02d" $minute)","$PERM" >> ${DATADIR}/2.graphPERM.csv
        echo "$(printf "%02d" $hour):$(printf "%02d" $minute)","$OK","$TEMP","$PERM" >> ${DATADIR}/2.graph.csv
    done
done

# Pretty graphing is pretty.
# Nothing is prettier that gnuplot
gnuplot -p ${BINDIR}/2.graph.gnuplot

# everyone loves compression, especially at PiedPiper
tar cvfz ${ZIPDIR}/2.graph.png.tgz --directory=${DATADIR} 2.graph.png 2.graphOK.png 2.graphTEMP.png 2.graphPERM.png 2>&1 > /dev/null
tar cvfz ${ZIPDIR}/2.graph.csv.tgz --directory=${DATADIR} 2.graph.csv 2.graphOK.csv 2.graphTEMP.csv 2.graphPERM.csv 2>&1 > /dev/null