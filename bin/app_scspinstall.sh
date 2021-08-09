#!/bin/bash

set -o nounset
set -o errexit

#### Description: Creates scsp folders
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   SCSP FOLDER INSTALL UTILS ###
###################################

mkdir -p /app/scsp/logs
mkdir -p /app/scsp/peticiones
mkdir -p /app/scsp/certificados
mkdir -p /app/scsp/xsd