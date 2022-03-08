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
    sudo apt-get autoremove
    
    sudo apt-get install ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    
    sudo apt-get remove docker docker-engine docker.io docker-compose docker-ce docker-ce-cli containerd.io
    sudo apt-get autoremove
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose zip

    if [ $(getent group docker) ]; then
        echo -e "group docker already exists: skipping group creation"
    else
        echo- e "group docker does not exist: adding group"
        sudo groupadd docker
    fi

    sudo usermod -aG docker $USER
    newgrp docker

    echo "starting"
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    sudo systemctl start docker.service
    sudo systemctl start containerd.service
    sudo systemctl status docker.service
    # sudo useradd -p $(openssl passwd -1 docker) docker -g docker
    # # sudo usermod -a -G docker emiserv
    # sudo usermod -a -G docker ${DOCKER_CUSTOM_USERNAME}
    sudo mkdir -p /app/docker
else
    echo ""
    echo "Docker unavailable"
    echo ""
fi



