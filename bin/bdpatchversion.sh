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
echo "[$(date +"%Y-%m-%d %T")] Loading database..."
echo ""

# Taking values from .env file
source $PROJECT_PATH/bin/loadenv.sh

VERSIONS_ARRAY=(1.4.10.error 1.4.10 1.4.11)

VERSIONS_PATH=${PROJECT_PATH}/source/versions

for VERSION in ${VERSIONS_ARRAY[*]}; do
  VERSION_FOLDER=${VERSIONS_PATH}/${VERSION}
  echo "Executing "$VERSION "version patch"
  if [ -d "$VERSION_FOLDER" ]; then
    # Copy section
    for FILE in $VERSION_FOLDER/*; do
      if [[ -f "$FILE" ]]; then
        echo Loading $FILE
        sudo docker exec -i ${LONG_APP_NAME_LOWER}-pg psql -v ON_ERROR_STOP=1 --username ${LONG_APP_NAME_LOWER} --dbname ${LONG_APP_NAME_LOWER} < $FILE
      fi
    done
  else
    echo "${VERSION_FOLDER} not found"
  fi
done




