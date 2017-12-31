#! /bin/bash


# This program allows the user to enter as many music CD's as they want

RESPONSE="y"			# Start with a yes so it loops

while  [ $RESPONSE == "y" ]	# Checks to see if the user wants to add another CD
do
    read -p "[Artist]: " ARTIST	# Promts for the artist
    read -p "[CD]: " CD
    read -p "[Year]: " YEAR
    
    # printf uses padding to make the columns the same size
    # Variables are in queotes because there might be spaces
    # Then it appends to the library
    printf '%-19s %-20s %-6s\n' "$ARTIST"  "|$CD"  "|$YEAR" >> library 
    read -p "Add a CD [y/n]: " RESPONSE	# Get whether the user wants to add anthoer CD
done

echo "Done"

