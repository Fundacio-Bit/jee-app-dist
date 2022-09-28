#!/bin/bash

set -o nounset
set -o errexit

#### Description: Checks Java and Maven version
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   Test environment values   ###
###################################

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] testing setup..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}

lib_env_utils.check_os

lib_env_utils.check_docker

# Deprecated
# lib_env_utils.check_docker_compose


echo ""
echo Checking Java version
echo ""
java -version
echo ""
echo Checking Maven version
echo ""
mvn -version
echo ""
echo Checking Maven settings
mvn help:effective-settings --settings $PROJECT_PATH/builds/maven-dist/maven/conf/settings.xml
echo ""

echo ""
echo Docker username $DOCKER_CUSTOM_USERNAME
echo Docker username on install $DOCKER_CUSTOM_USERNAME_ON_INSTALL

echo ""
echo Checking Docker version
echo ""
docker version
echo ""

echo ""
echo Checking Docker Compose Version
echo ""
docker compose version
echo ""
