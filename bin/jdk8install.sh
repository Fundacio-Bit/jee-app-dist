#!/bin/bash
#### Description: Downloads and installs jdk 8 binaries
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   JDK 8 INSTALL UTILS         ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Installing JDK 8..."
echo ""

source $PROJECT_PATH/bin/loadenv.sh

echo "Downloading" $JDK8_URL "to" $JDK8_TARGET

wget --no-cookies --no-check-certificate --header \
     "Cookie: oraclelicense=accept-securebackup-cookie" \
     $JDK8_URL -P $JDK8_TARGET

tar -zxvf $JDK8_TARGET/$JDK8_TARFILE --directory $JDK8_TARGET
rm $JDK8_TARGET/$JDK8_TARFILE