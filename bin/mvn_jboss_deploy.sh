#!/bin/bash

set -o nounset
set -o errexit

#### Description: Build and deploy from source
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   DEPLOY MVN UTILS          ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Build and deploy project..."
echo ""

# Taking values from .env file
source $PROJECT_PATH/bin/_app__loadenv.sh

echo off
if [[ -f help.txt ]]
then
  cat help.txt
else
  echo "help.txt no existe"
fi

# Array to compile
POM_ARRAY=($APP_POM_FILE $SAR_POM_FILE)
# Array to deploy
# FILE_ARRAY=($EAR_FILE $SAR_FILE $DS_FILE)

FILE_ARRAY=($EAR_FILE $DS_FILE)
PROPERTIES_ARRAY=($PROPERTIES_FILE $SYSTEM_PROPERTIES_FILE)

# POM compile section
for POM in ${POM_ARRAY[*]}; do
  if [[ -f "$POM" ]]
  then
      echo "Compiling $POM"
      env mvn -f $POM -DskipTests $@ install \
        --settings $PROJECT_PATH/builds/maven-dist/maven/conf/settings.xml \
        --toolchains $PROJECT_PATH/builds/maven-dist/maven/conf/toolchains.xml
  fi
done
# end of POM compile section

# Deploy section
# Check if there are errors
if [ $? == 0 ]; then
  # Check if JBOSS_DEPLOY_DIR value exists
  # TODO: MANAGE THIS AS AN ARRAY 
  if [ "$JBOSS_DEPLOY_DIR" == "" ]; then
    # Deploy dir value is empty
    echo  =================================================================
    echo    Definex la variable d\'entorn JBOSS_DEPLOY_DIR apuntant al
    echo    directori de deploy del JBOSS  i automaticament s\'hi copiara
    echo    l\'ear generat.
    echo  =================================================================
    # End of not deploydir section
  else
    # Deploy dir value is informed
    echo on
    # Check if JBOSS_DEPLOY_DIR directory exists 
    if [ -d "$JBOSS_DEPLOY_DIR" ]; then
      ### Take action if $DIR exists ###
      echo --------- COPIANT FITXERS AL DESTÍ $JBOSS_DEPLOY_DIR ---------
    else
      ###  Control will jump here if dir does NOT exists ###
      echo "${JBOSS_DEPLOY_DIR} not found. Creating ..."
      mkdir -p $JBOSS_DEPLOY_DIR
    fi

    echo on
    # Check if JBOSS_CONFIG_DIR directory exists 
    if [ -d "$JBOSS_CONFIG_DIR" ]; then
      ### Take action if $DIR exists ###
      echo --------- COPIANT FITXERS AL DESTÍ $JBOSS_DEPLOY_DIR ---------
    else
      ###  Control will jump here if dir does NOT exists ###
      echo "${JBOSS_CONFIG_DIR} not found. Creating ..."
      mkdir -p $JBOSS_CONFIG_DIR
    fi
    # TODO END

    # End Check if JBOSS_DEPLOY_DIR directory exists 

    # Copy section
    for FILE in ${FILE_ARRAY[*]}; do
      if [[ -f "$FILE" ]]; then
        echo "Copying $FILE to $JBOSS_DEPLOY_DIR"
        cp $FILE $JBOSS_DEPLOY_DIR
      fi
    done


    for FILE in ${PROPERTIES_ARRAY[*]}; do
      if [[ -f "$FILE" ]]; then
        echo "Copying $FILE to $JBOSS_CONFIG_DIR"
        cp $FILE $JBOSS_CONFIG_DIR
      fi
    done
    # End of copy section
  fi
  # End of check if JBOSS_DEPLOY_DIR exists
fi
# End of deploy section
