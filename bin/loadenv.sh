#!/bin/bash
#### Description: Loads environment variables from .env file
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   LOAD ENV UTILS            ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Loading .env file..."
echo ""

while read line; do 
    # Define the string value
    # Set space as the delimiter
    IFS='='
    #Read the split words into an array based on space delimiter
    read -a strarr <<< "$line"
    #Count the total words
    #echo "There are ${#strarr[*]} words in the text."
    key="${strarr[0]}"
    value="${strarr[1]}"
    export $key=$(eval echo $value)
    echo "$key : $(eval echo \${$key})" 
done < <(cat ${PROJECT_PATH}/.env | grep -v "#" | grep -v "^$")
