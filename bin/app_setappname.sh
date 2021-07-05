#!/bin/bash

set -o nounset
set -o errexit

#### Description: 
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   SETUP UTILS         ###
###################################

spinal_to_camelcase() {
    IFS=- read -ra str <<<"$1"
    printf '%s' "${str[@]^}"
}

spinal_to_lower() {
    IFS=- read -ra str <<<"$1"
    printf '%s' "${str[@],,}"
}

spinal_to_upper() {
    IFS=- read -ra str <<<"$1"
    printf '%s' "${str[@]^^}"
}


echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Setting local app name..."
echo ""

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
 
 
    case $key in
        LONG_APP_NAME)
        echo "Value substitution for $key"
        export $key=$(eval echo $NEW_LONG_APP_NAME)
        echo "$key : $(eval echo \${$key})"
        # TODO: Finish substitution in file
        ;;
        SHORT_APP_NAME)
        echo "Value substitution for $key"
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

rm ${settings_file_pattern}.new


# LONG_APP_NAME_UPPER=EMISERVBACKOFFICE
# LONG_APP_NAME_LOWER=emiservbackoffice
# LONG_APP_NAME_CAMEL=EmiservBackoffice
# SHORT_APP_NAME_UPPER=EBO
# SHORT_APP_NAME_LOWER=ebo
# SHORT_APP_NAME_CAMEL=Ebo


