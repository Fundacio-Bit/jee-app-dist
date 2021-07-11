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

CFPATH=$KEYCLOAK_CONF_PATH
echo "Processing: "$CFPATH
TEMPLATE_FOLDER=$CFPATH.template.d
SETTINGS_FOLDER=$CFPATH


if [ "$KEYCLOAK_IMPORT_REALM_JSON" == "" ]; then
    # Deploy dir value is empty
    echo  =================================================================
    echo    Definex la variable d\'entorn KEYCLOAK_IMPORT_REALM_JSON apuntant al
    echo    directori de configuracio del JBOSS  
    echo  =================================================================
else
    if [[ -f "$TEMPLATE_FOLDER/$KEYCLOAK_IMPORT_REALM_JSON" ]]; then
        echo Copying TEMPLATE_FOLDER/$KEYCLOAK_IMPORT_REALM_JSON to $KEYCLOAK_CONF_PATH
        cp $TEMPLATE_FOLDER/$KEYCLOAK_IMPORT_REALM_JSON $SETTINGS_FOLDER/import-goib-realm.json
    fi
fi


echo ""

