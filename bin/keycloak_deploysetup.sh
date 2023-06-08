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

CONF_PATH_ARRAY=($KEYCLOAK_DEPLOYCONF_PATH $KEYCLOAK_BIN_CLI_PATH)
# echo $JBOSS_EAP_52_CONF_PATH
for CFPATH in ${CONF_PATH_ARRAY[*]}; do
    echo ""
    echo "Processing folder: "$CFPATH
    #TEMPLATE_FOLDER=$DEPLOY_CONF_PATH.template.d
    #SETTINGS_FOLDER=$DEPLOY_CONF_PATH
    TEMPLATE_FOLDER=$CFPATH.template.d
    SETTINGS_FOLDER=$CFPATH

    mkdir -p $SETTINGS_FOLDER
    echo "Procesing template folder: $TEMPLATE_FOLDER"
    echo "Configuration at $KEYCLOAK_DEPLOYCONF_PATH"
    echo ""

    for FILE in $TEMPLATE_FOLDER/*; do

        if [ "$TEMPLATE_FOLDER" == "$KEYCLOAK_DEPLOYCONF_PATH.template.d" ]; then
            
            if [ "$KEYCLOAK_IMPORT_REALM_JSON" == "" ]; then
                # Deploy dir value is empty
                echo  =================================================================
                echo    Definex la variable d\'entorn KEYCLOAK_IMPORT_REALM_JSON apuntant al
                echo    directori de configuracio del JBOSS  
                echo  =================================================================
            else
                echo "Realm json file $KEYCLOAK_IMPORT_REALM_JSON as json for $FILE " 

                if [[ -f "${TEMPLATE_FOLDER}/import-goib-realm.json" ]]; then
                    echo Copying default $TEMPLATE_FOLDER/import-goib-realm.json to $KEYCLOAK_DEPLOYCONF_PATH
                    mkdir -p $SETTINGS_FOLDER
                    cp $TEMPLATE_FOLDER/import-goib-realm.json $SETTINGS_FOLDER/import-goib-realm.json
                fi

                if [[ -f "$TEMPLATE_FOLDER/$KEYCLOAK_IMPORT_REALM_JSON" ]]; then
                    rm $SETTINGS_FOLDER/import-goib-realm.json
                    echo Copying $TEMPLATE_FOLDER/$KEYCLOAK_IMPORT_REALM_JSON to $KEYCLOAK_DEPLOYCONF_PATH
                    mkdir -p $SETTINGS_FOLDER
                    cp $TEMPLATE_FOLDER/$KEYCLOAK_IMPORT_REALM_JSON $SETTINGS_FOLDER/import-goib-realm.json        
                fi

            fi

        else
            echo ""
            echo "Loading: "$FILE
            echo ""
            MASK=${FILE%.template}
            FILENAME=${MASK##*/}
            NEWFILE=$SETTINGS_FOLDER/$FILENAME
            echo "Transforming filename from $FILE to $NEWFILE"
            cp $FILE $NEWFILE
        fi

       

    done

done


echo ""

