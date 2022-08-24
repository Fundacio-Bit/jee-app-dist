#!/bin/bash

#set -o nounset
#set -o errexit

#### Description: Loads environment variables from .env file
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

#### THIS FILE USED TO BE SOURCED. THINK TWICE BEFORE UPDATE.
#### EXECUTING BY YOURSELF WILL ONLY TAKE EFFECT IN YOUR CURRENT SHELL.

###################################
###   LOAD ENV UTILS            ###
###################################



##################################################################
##################################################################

lib_env_utils.check_os(){
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac

    echo "Your OS is ${machine} according uname=${unameOut}"

    isLinux=0
    # Assign mode 1 if so is linux or mac, 0 otherwise
    if [[ ${machine} == "Linux" || ${machine} == "Mac" ]]; then
        isLinux=1
    fi
}

##################################################################
##################################################################

lib_env_utils.check_docker_compose(){

    COMMAND=docker-compose
    
    echo ""

    echo "Checking $COMMAND settings ..."

    DOCKER_COMPOSE=/dev/null
    if command -v $COMMAND > /dev/null; then
        DOCKER_COMPOSE=$(command -v $COMMAND)
        echo $COMMAND is available at $DOCKER_COMPOSE
    else
        echo $COMMAND is not available. $COMMAND set to $DOCKER_COMPOSE
    fi

}


lib_env_utils.check_docker(){

    COMMAND=docker
    
    echo ""
    echo "Checking $COMMAND settings ..."

    DOCKER=/dev/null
    if command -v $COMMAND > /dev/null; then
        DOCKER=$(command -v $COMMAND)
        echo $COMMAND is available at $DOCKER
    else
        echo $COMMAND is not available. $COMMAND set to $DOCKER
    fi

}

##################################################################
##################################################################



lib_env_utils.loadenv(){

    echo ""
    echo "[$(date +"%Y-%m-%d %T")] Loading env..."
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
    done < <(cat $1/.env | grep -v "#" | grep -v "^$")

}

##################################################################
##################################################################

echo ""
echo lib_env_utils.sh loaded
echo lib_string_utils.sh may be required
echo ""


