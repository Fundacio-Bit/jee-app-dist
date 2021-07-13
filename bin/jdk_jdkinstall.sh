#!/bin/bash

set -o nounset
set -o errexit

#### Description: Downloads and installs jdk binaries
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   JDK INSTALL UTILS         ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Installing JDK..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""
lib_env_utils.check_os
echo ""

if [ -d "$JDK_TARGET" ]; then
    ### Take action if $DIR exists ###
    echo --------- COPIANT FITXERS AL DESTÍ $JDK_TARGET ---------
else
    ###  Control will jump here if dir does NOT exists ###
    echo "${JDK_TARGET} not found. Creating ..."
    mkdir -p $JDK_TARGET
fi

if [[ isLinux -eq 1 ]]; then
    JDK_FILE=${JDK_LINUX_FILE}
    JDK_URL=${JDK_BASEURL}${JDK_FILE}
    echo ""
    echo "Downloading" $JDK_URL "to" $JDK_TARGET
    echo ""
    wget $JDK_URL -P $JDK_TARGET
    tar -zxvf $JDK_TARGET/$JDK_FILE --directory $JDK_TARGET
else
    JDK_FILE=${JDK_WINDOWS_FILE}
    JDK_URL=${JDK_BASEURL}${JDK_FILE}
    echo ""
    echo "Downloading" $JDK_URL "to" $JDK_TARGET
    echo ""
    curl $JDK_URL > $JDK_TARGET/$JDK_FILE
    unzip -o $JDK_TARGET/$JDK_FILE -d $JDK_TARGET
fi  

rm $JDK_TARGET/$JDK_FILE