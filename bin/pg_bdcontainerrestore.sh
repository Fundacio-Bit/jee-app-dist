#!/bin/bash

set -o nounset
set -o errexit

#### Description: Restoring database using pg_restore
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   RESTORE UTILS             ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Restoring database..."
echo ""

# Taking values from .env file
source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""
lib_env_utils.check_os
echo ""
lib_env_utils.check_docker
echo ""

if [[ "${DOCKER}" == "/dev/null" ]]; then
  echo "Docker not installed. Exiting"
  exit 1
fi

echo Restoring container bd with $SCHEMA_ONLY option
${DOCKER} exec -i ${LONG_APP_NAME_LOWER}-pg pg_restore \
    --file=${PG_DUMP_FILENAME} \
    --format=t \
    --verbose \
    --schema=${PG_DUMP_SCHEMA} \
    --column-inserts \
    --host=${PG_DUMP_HOSTNAME} \
    --port=${PG_DUMP_PORT} \
    --username=${PG_DUMP_NAME} \
    ${PG_DUMP_DBNAME}