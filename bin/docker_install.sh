#!/bin/bash

set -o nounset
set -o errexit

#### Description: Installs docker.
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021
#### WARNING: Check if DOCKER_CUSTOM_USERNAME is set. See settings/500_docker file

###################################
###   DOCKER INSTALL UTILS      ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Installing docker..."
echo ""

# Taking values from .env file

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""
lib_env_utils.check_os
echo ""

if [[ isLinux -eq 1 ]]; then
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get remove docker docker-engine docker.io docker-compose
    sudo apt-get autoremove
    sudo apt-get install docker.io docker-compose zip
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo systemctl status docker
    sudo useradd -p $(openssl passwd -1 docker) docker -g docker
    # sudo usermod -a -G docker emiserv
    sudo usermod -a -G docker ${DOCKER_CUSTOM_USERNAME}
    sudo mkdir -p /app/docker
else
    echo ""
    echo "Docker unavailable"
    echo ""
fi



