#!/bin/bash

set -o nounset
set -o errexit

#### Description: Build from source
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   BUILD MVN UTILS           ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Build and deploy project..."
echo ""

# Taking values from .env file
source $PROJECT_PATH/bin/app_loadenv.sh

echo off
if [[ -f help.txt ]]
then
  cat help.txt
else
  echo "help.txt no existe"
fi


if [ "$APP_FOLDER" == "" ]; then
  # Project dir value is empty
  echo  =================================================================
  echo    Definex la variable d\'entorn APP_FOLDER apuntant al
  echo    directori del projecte a generar.
  echo  =================================================================
  # End of not project section
else
  # Project dir value is informed
  echo on
  # Check if APP_FOLDER directory exists 
  if [ -d "$APP_FOLDER" ]; then
    ### Take action if $DIR exists ###
    echo --------- La carpeta $APP_FOLDER existeix  ---------
  else
    ###  Control will jump here if dir does NOT exists ###
    echo "${APP_FOLDER} not found. Creating ..."
    mkdir -p $APP_FOLDER
  fi

  cd $PROJECT_PATH/..

  MAVEN_OPTS="-Dfile.encoding=UTF-8" && mvn org.apache.maven.plugins:maven-archetype-plugin:3.2.0:generate \
      -B -DarchetypeGroupId=es.caib.projectebase \
      -DarchetypeArtifactId=projectebase-archetype \
      -DarchetypeVersion=1.0.9 \
      -Dpackage=es.caib.${LONG_APP_NAME_LOWER} \
      -Dpackagepath=es/caib/${LONG_APP_NAME_LOWER} \
      -Dinversepackage=${LONG_APP_NAME_LOWER}.caib.es \
      -DgroupId=es.caib.${LONG_APP_NAME_LOWER} \
      -DartifactId=${LONG_APP_NAME_LOWER} \
      -Dversion=1.0.0 \
      -Dprojectname=${LONG_APP_NAME_CAMEL} \
      -Dprojectnameuppercase=${LONG_APP_NAME_UPPER} \
      -Dprefix=${SHORT_APP_NAME_LOWER} \
      -Dprefixuppercase=${SHORT_APP_NAME_UPPER} \
      -DperfilBack=${perfilBack} \
      -DperfilFront=${perfilFront} \
      -DperfilApiInterna=${perfilApiInterna} \
      -DperfilApiExterna=${perfilApiExterna} \
      -DperfilApiFirmaSimple=${perfilApiFirmaSimple} \
      -DperfilArxiu=${perfilArxiu} \
      -DperfilRegistre=${perfilRegistre} \
      -DperfilNotib=${perfilNotib} \
      -DperfilDir3Caib=${perfilDir3Caib} \
      -DperfilDistribucio=${perfilDistribucio} \
      -DperfilPinbal=${perfilPinbal} \
      -DperfilSistra2=${perfilSistra2} \
      --settings $PROJECT_PATH/builds/maven-dist/maven/conf/settings.xml
    
  cd $PROJECT_PATH

fi

  




















