#!/bin/bash
#### Description: Starts all containers
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###         Start               ###
###################################

DOCKER_COMPOSE=$(which docker-compose)
echo "docker-compose at $DOCKER_COMPOSE"

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Stopping lingering containers..."
echo ""

source $PROJECT_PATH/bin/loadenv.sh

export USER_ID=${UID}
export GROUP_ID=${UID}

${DOCKER_COMPOSE} \
    -f ${DOCKER_COMPOSE_FILE} \
    down --remove-orphans    

echo "[$(date +"%Y-%m-%d %T")] Starting the containers..."

${DOCKER_COMPOSE} \
    -f ${DOCKER_COMPOSE_FILE} \
    up -d --build    

${DOCKER_COMPOSE} \
    -f ${DOCKER_COMPOSE_FILE} \
    logs -f --tail 40    


# ${DOCKER_COMPOSE} -f ${PROJECT_PATH}/docker-compose.api.yml logs -f