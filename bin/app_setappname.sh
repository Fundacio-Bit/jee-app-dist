#!/bin/bash

set -o nounset
set -o errexit

#### Description: 
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   SETUP UTILS         ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Setting local app name..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh

remaining=2

settings_file_pattern=${PROJECT_PATH}/settings/100_app
cp ${settings_file_pattern} ${settings_file_pattern}.new

for i in "$@"
do
    case $i in
        -codapp=*|--codapp=*)
        NEW_LONG_APP_NAME="${i#*=}"
        let "remaining--"
        shift # past argument=value
        ;;
        -app=*|--app=*)
        NEW_SHORT_APP_NAME="${i#*=}"
        let "remaining--"
        shift # past argument=value
        ;;
        *)
            # unknown option
        ;;
    esac
done

if [[ remaining -eq 0 ]]; then
    echo Setting LONG_APP_NAME to $NEW_LONG_APP_NAME
    export NEW_LONG_APP_NAME
    echo Setting SHORT_APP_NAME to $NEW_SHORT_APP_NAME
    export NEW_SHORT_APP_NAME
else
    if [[ remaining -eq 2 ]]; then
        echo Loading default values
        exit 0
    else
        echo Wrong number of parameters $remaining more expected
        exit 1
    fi
fi

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
 
    current_value=$(eval echo $value)

    case $key in
        LONG_APP_NAME)
        lib_string_utils.replace_key_value $key $current_value $NEW_LONG_APP_NAME ${settings_file_pattern}.new 
        export $key=$(eval echo $NEW_LONG_APP_NAME)
        echo "$key : $(eval echo \${$key})"
        ;;
        SHORT_APP_NAME)
        lib_string_utils.replace_key_value $key $current_value $NEW_SHORT_APP_NAME ${settings_file_pattern}.new 
        export $key=$(eval echo $NEW_SHORT_APP_NAME)
        echo "$key : $(eval echo \${$key})" 
        ;;
        *)
        echo "No value substitution for $key"
        export $key=$(eval echo $value)
        echo "$key : $(eval echo \${$key})" 
        ;;
    esac
done < <(cat ${settings_file_pattern} | grep -v "#" | grep -v "^$")

mv ${settings_file_pattern}.new ${settings_file_pattern}