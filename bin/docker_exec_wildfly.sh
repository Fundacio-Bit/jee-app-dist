#!/bin/bash

set -o nounset
set -o errexit

#### Description: Runs webapp docker container
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###         Exec                ###
###################################

DOCKER=$(which docker)
echo "docker at $DOCKER"

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Launching web server..."
echo ""

source $PROJECT_PATH/bin/app_loadenv.sh

${DOCKER} exec -i -t wildfly-${LONG_APP_NAME_LOWER} /bin/bash