#!/bin/bash

set -o nounset
set -o errexit

#### Description: Starts all containers
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###         Start               ###
###################################

COMMAND=docker

DOCKER=$(command -v $COMMAND)
echo "docker at $DOCKER"

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Stopping lingering containers..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""
lib_env_utils.check_os
echo ""
lib_env_utils.check_docker
echo ""

if [[ "${DOCKER}" == "/dev/null" ]]; then
  echo "docker compose not installed. Exiting"
  exit 1
fi

export USER_ID=${UID}
export GROUP_ID=${UID}

#${DOCKER} compose \
#    -f ${DOCKER_COMPOSE_FILE} \
#    down --remove-orphans    

echo "[$(date +"%Y-%m-%d %T")] Starting the containers..."

${DOCKER} compose \
    -f ${DOCKER_COMPOSE_FILE} \
    up -d --build

${DOCKER} compose \
    -f ${DOCKER_COMPOSE_FILE} \
    logs -f --tail 40    


# ${DOCKER} compose -f ${PROJECT_PATH}/docker-compose.api.yml logs -f