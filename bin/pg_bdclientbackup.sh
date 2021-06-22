#!/bin/bash

set -o nounset
set -o errexit

#### Description: Backup database using pg_dump
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   BACKUP UTILS              ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Saving database..."
echo ""

# Taking values from .env file
source $PROJECT_PATH/bin/app_loadenv.sh

echo Saving with $SCHEMA_ONLY option
${PG_PATH}/pg_dump $SCHEMA_ONLY \
    --file=${PG_DUMP_FILENAME} \
    --format=t \
    --verbose \
    --schema=${PG_DUMP_SCHEMA} \
    --column-inserts \
    --host=${PG_DUMP_HOSTNAME} \
    --port=${PG_DUMP_PORT} \
    --username=${PG_DUMP_NAME} \
    ${PG_DUMP_DBNAME}