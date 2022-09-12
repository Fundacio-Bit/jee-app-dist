#!/bin/bash

#set -o nounset
#set -o errexit

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
    
    sudo apt-get remove \
        docker \
        docker.io \
        docker-compose \
        containerd \
        runc

    echo "remove docker docker.io docker-compose containerd runc"

    sudo apt-get remove docker-engine
    echo "remove docker-engine"

    sudo apt-get autoremove
    
    sudo apt-get update

    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o  /etc/apt/keyrings/docker.gpg

    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    echo Adding: \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable"

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo docker run hello-world

    # TO DO:  Check path if needed
    sudo mkdir -p /app/docker

else
    echo ""
    echo "Docker should be installed manually"
    echo ""
fi



