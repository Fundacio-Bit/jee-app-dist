#!/bin/bash

set -o nounset
set -o errexit

#### Description: Creates custom deploy files from template
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   SETUP UTILS               ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Setting .template files..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}

CFPATH=$NGINX_CONF_PATH
echo "Processing: "$CFPATH
TEMPLATE_FOLDER=$CFPATH.template.d
SETTINGS_FOLDER=$CFPATH


if [ "$NGINX_CONF_FILE" == "" ]; then
    # Deploy dir value is empty
    echo  =================================================================
    echo    Definex la variable d\'entorn NGINX_CONF_FILE apuntant al
    echo    directori de configuracio del NGINX 
    echo  =================================================================
else
    if [[ -f "$TEMPLATE_FOLDER/$NGINX_CONF_FILE" ]]; then
        echo Copying $TEMPLATE_FOLDER/$NGINX_CONF_FILE to $NGINX_CONF_PATH
        mkdir -p $SETTINGS_FOLDER
        cp $TEMPLATE_FOLDER/$NGINX_CONF_FILE $SETTINGS_FOLDER/default.conf
    fi
fi

if [ "$NGINX_OPENSSL_CONF_FILE" == "" ]; then
    # Deploy dir value is empty
    echo  =================================================================
    echo    Definex la variable d\'entorn OPENSSL_CONF_FILE apuntant al
    echo    directori de configuracio del NGINX 
    echo  =================================================================
else
    if [[ -f "$TEMPLATE_FOLDER/$NGINX_OPENSSL_CONF_FILE" ]]; then
        echo Copying $TEMPLATE_FOLDER/$NGINX_OPENSSL_CONF_FILE to $NGINX_CONF_PATH
        mkdir -p $SETTINGS_FOLDER
        cp $TEMPLATE_FOLDER/$NGINX_OPENSSL_CONF_FILE $SETTINGS_FOLDER/openssl.conf
    fi
fi



echo ""

