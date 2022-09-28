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

echo ""


PROJECT_PROPERTIES_FOLDER=${APP_PROJECT_FOLDER}/scripts/configuracio
if [ -d "$PROJECT_PROPERTIES_FOLDER" ]; then
  # Copy section
  for FILE in $PROJECT_PROPERTIES_FOLDER/*.properties; do
    if [[ -f "$FILE" ]]; then
      echo Loading $FILE
      mkdir -p $WILDFLY_PROPERTIESCONF_PATH
      cp $FILE $WILDFLY_PROPERTIESCONF_PATH
    fi
  done
else
  echo "${PROJECT_PROPERTIES_FOLDER} not found"
fi

echo ""

PROJECT_DATASOURCES_FOLDER=${APP_PROJECT_FOLDER}/scripts/datasources/${APP_PROJECT_SGBD}
if [ -d "$PROJECT_DATASOURCES_FOLDER" ]; then
  # Copy section
  for FILE in $PROJECT_DATASOURCES_FOLDER/*-ds.xml; do
    if [[ -f "$FILE" ]]; then
      echo Loading $FILE
      mkdir -p $WILDFLY_DEPLOYCONF_PATH
      cp $FILE $WILDFLY_DEPLOYCONF_PATH
    fi
  done
else
  echo "${PROJECT_DATASOURCES_FOLDER} not found"
fi



CONF_PATH_ARRAY=($JBOSS_EAP_52_DEPLOYCONF_PATH $WILDFLY_DEPLOYCONF_PATH $WILDFLY_PROPERTIESCONF_PATH $WILDFLY_BIN_CLI_PATH)
# echo $JBOSS_EAP_52_CONF_PATH
for CFPATH in ${CONF_PATH_ARRAY[*]}; do
    echo "Processing: "$CFPATH
    #TEMPLATE_FOLDER=$DEPLOY_CONF_PATH.template.d
    #SETTINGS_FOLDER=$DEPLOY_CONF_PATH
    TEMPLATE_FOLDER=$CFPATH.template.d
    SETTINGS_FOLDER=$CFPATH

    mkdir -p $SETTINGS_FOLDER
    for FILE in $TEMPLATE_FOLDER/*; do
        echo "Loading: "$FILE
        MASK=${FILE%.template}
        FILENAME=${MASK##*/}
        NEWFILE=$SETTINGS_FOLDER/$FILENAME
        echo "Transforming filename from $FILE to $NEWFILE"
        cp $FILE $NEWFILE
    done

done


echo ""

