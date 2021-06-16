#!/bin/bash

set -o nounset
set -o errexit

#### Description: Build from source
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   BUILD MVN UTILS           ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Build and deploy project..."
echo ""

# Taking values from .env file
source $PROJECT_PATH/bin/loadenv.sh

echo off
if [[ -f help.txt ]]
then
  cat help.txt
else
  echo "help.txt no existe"
fi

# Array to compile
POM_ARRAY=($APP_POM_FILE $SAR_POM_FILE)
# Array to deploy
FILE_ARRAY=($EAR_FILE $SAR_FILE $DS_FILE)

# POM compile section
for POM in ${POM_ARRAY[*]}; do
  if [[ -f "$POM" ]]
  then
      echo "Compiling $POM"
      env mvn -f $POM -DskipTests $@ install \
        --settings $PROJECT_PATH/builds/maven-dist/maven/conf/settings.xml \
        --toolchains $PROJECT_PATH/builds/maven-dist/maven/conf/toolchains.xml
  fi
done
# end of POM compile section


