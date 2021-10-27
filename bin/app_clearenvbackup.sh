#!/bin/bash

set -o nounset
set -o errexit

#### Description: Removes *.backup files
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

#########################################
###   CLEAR ENVIRONMENT BACKUP UTILS  ###
#########################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at ${PROJECT_PATH}"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Clearing backup files..."
echo ""

for FILE in settings/*.backup; do
    echo "Removing "${FILE}
    rm ${FILE}
done
echo ""
