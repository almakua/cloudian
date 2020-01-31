#!/usr/bin/env gnuplot

#FULL GRAPH
# use histogram graph
set style data histogram
set style histogram cluster

# use png and pecify a bit of picture specification
set term png nocrop enhanced size 4800,2400 font "ubuntu,12.0"
set output "data/2.graph.png"

# vertical labels for the x axis
set xtics rotate
# histogram bars should be full, and with a solid black border
set style fill solid border rgb "black"
# a bit of data prepping
set auto x
set yrange [0:*]
set xlabel 'Time'
set ylabel '# of occurrencies'
set datafile separator ","

# input file, and using column 2,3,4 as data set, and column 1 as x axis label.
# using the first row as data set headers
plot 'data/2.graph.csv' using 2:xtic(1) title col(2),\
        '' using 3 title col(3), \
        '' using 4 title col(4), 

# OK GRAPH
set style data histogram
set style histogram cluster

set term png nocrop enhanced size 4800,2400 font "ubuntu,12.0"
set output "data/2.graphOK.png"

set xtics rotate
set style fill solid border rgb "black"
set auto x
set yrange [0:*]
set xlabel 'Time'
set ylabel '# of occurrencies'
set datafile separator ","

plot 'data/2.graphOK.csv' using 2:xtic(1) title col(2)



#TEMP GRAPH
set style data histogram
set style histogram cluster

set term png nocrop enhanced size 4800,2400 font "ubuntu,12.0"
set output "data/2.graphTEMP.png"

set xtics rotate
set style fill solid border rgb "black"
set auto x
set yrange [0:*]
set xlabel 'Time'
set ylabel '# of occurrencies'
set datafile separator ","

plot 'data/2.graphTEMP.csv' using 2:xtic(1) title col(2)



# PERM GRAPH
set style data histogram
set style histogram cluster

set term png nocrop enhanced size 4800,2400 font "ubuntu,12.0"
set output "data/2.graphPERM.png"

set xtics rotate
set style fill solid border rgb "black"
set auto x
set yrange [0:*]
set xlabel 'Time'
set ylabel '# of occurrencies'
set datafile separator ","

plot 'data/2.graphPERM.csv' using 2:xtic(1) title col(2)
