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
source $PROJECT_PATH/bin/_app__loadenv.sh

APPLICATION_PATH=${PROJECT_PATH}/../${LONG_APP_NAME_LOWER}/scripts/bbdd/${APP_VERSION}/${APP_SGBD}
echo "Processing $APPLICATION_PATH"
if [ -d "$APPLICATION_PATH" ]; then
  # Copy section
  for FILE in $APPLICATION_PATH/*; do
    if [[ -f "$FILE" ]]; then
      echo Loading $FILE
      sudo docker exec -i ${LONG_APP_NAME_LOWER}-pg psql -v ON_ERROR_STOP=1 --username ${LONG_APP_NAME_LOWER} --dbname ${LONG_APP_NAME_LOWER} < $FILE
    fi
  done
  exit 0
else
  echo "${APPLICATION_PATH} not found"
  exit 1
fi
