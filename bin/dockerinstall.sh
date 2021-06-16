#!/bin/bash

set -o nounset
set -o errexit

#### Description: Installs docker
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   DOCKER INSTALL UTILS      ###
###################################

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
sudo usermod -a -G docker ${CUSTOM_USERNAME}
sudo mkdir -p /app/docker
