#!/bin/bash

set -o nounset
set -o errexit

#### Description: Creates data folders
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 09-2022

###################################
###   DATA FOLDER INSTALL UTILS ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Getting to create folder..."
echo ""

# Taking values from .env file

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""

DATA_FOLDER=$APP_FILES_BASE_FOLDER

# Paths to deprecate
# /app/scsp/logs
# /app/scsp/peticiones
# /app/scsp/certificados
# /app/scsp/xsd

# New default suggested paths. See 100_app file
# ${APP_PROJECT_PATH}/data/assets (cert files, xsd)
# ${APP_PROJECT_PATH}/data/bundle (deployable content)
# ${APP_PROJECT_PATH}/data/var (log, other generated files)

mkdir -p $DATA_FOLDER

IFS=' '
#Read the split words into an array based on space delimiter
read -a SUBFOLDER_ARRAY <<< ${APP_FILES_SUBFOLDER_ARRAY}

# VERSIONS_ARRAY=${APP_PROJECT_DB_PATCH_ARRAY}

SUBFOLDER_PATH=${DATA_FOLDER}

for SUBFOLDER in ${SUBFOLDER_ARRAY[*]}; do
  SF=${SUBFOLDER_PATH}/${SUBFOLDER}  
  echo "Creating "$SF" folder"
  mkdir -p $SF
done


