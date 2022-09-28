#!/bin/bash

set -o nounset
set -o errexit

#### Description: Downloads and installs wildfly aux binaries
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   WILDFLY INSTALL UTILS     ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Getting goibusuari..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}

# TODO: USE THE RIGHT URL. This does not work
# TODO: GOIBUSUARI_EAR_URL=https://github.com/GovernIB/docker-imatges/blob/docker-imatges-1.0/wildfly-14.0.1/files/goibusuari.ear?raw=true

GOIBUSUARI_EAR_URL=https://github.com/GovernIB/docker-imatges/raw/docker-imatges-1.0/wildfly-14.0.1/files/goibusuari.ear
GOIBUSUARI_EAR_TARGET=$PROJECT_PATH/builds/wildfly-dist/wildfly/deploy

#echo "Downloading" $GOIBUSUARI_EAR_URL "to" $GOIBUSUARI_EAR_TARGET
#wget $GOIBUSUARI_EAR_URL -P $GOIBUSUARI_EAR_TARGET

mkdir -p ${JBOSS_DEPLOY_DIR}
cp ${GOIBUSUARI_EAR_TARGET}/goibusuari.ear ${JBOSS_DEPLOY_DIR}