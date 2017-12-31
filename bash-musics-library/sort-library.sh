#! /bin/bash

# This program allows you to sort by different columns
# Takes in two CLI arguments,
#1: [0-2] col number and 2: [-r] 

# Get_Column takes two arguments, the first is the column number
# And the second is the current line of the library
# It sends the correct column of the library to file TEMP

# TODO: 1. Get --help working


if [ "$1" == "--help" ]
then
    printf "Sorts your library by Artist, CD, Year, and can reverse the sort\n\nsort-library 0-2 [-r]\n"
    exit 1
fi

Get_Column () {
    IFS='|'			# Change the divisor to |
    read -ra COLX <<< "$2"	# Makes an array current line
    # Outputs the command line arugument #1 column to TEMP
    echo ${COLX[$1]} >> TEMP    
}

touch TEMP			# Create TEMP

X=-2				# Count var, get rid of header
IFS=''				# Preserves white space

# Loads the library and reads it in a loop
cat library | while read LINE	
do
    IFS=''			# Not reset
    X=`expr $X + 1`		# ++
    if [ "$X" -gt 0 ]		# When in positive do something
    then
	Get_Column $1 $LINE	# Argument 1 from command line
    fi
done
	       
if [ "$2" == "-r" ]		# If Arg 2 is -r then reverse
then
    sort -r TEMP			# Sort in reverse correct col
else
    sort TEMP			# Else sort normally
fi

rm TEMP				# Delete temp, not needed
