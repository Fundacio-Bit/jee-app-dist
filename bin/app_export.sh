#!/bin/bash

set -o nounset
set -o errexit

#### Description: Export all local values
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

######################################
###  EXPORT FROM TEMPLATE UTILS    ###
######################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Setting .backup files..."
echo ""

EXPORTED_FOLDER=.exported
mkdir -p ${EXPORTED_FOLDER}



JBOSS_CONF_PATH_ARRAY=($JBOSS_EAP_52_DEPLOYCONF_PATH $WILDFLY_DEPLOYCONF_PATH $WILDFLY_PROPERTIESCONF_PATH $WILDFLY_BIN_CLI_PATH)


# SETTINGS_FOLDER=settings


# for FILE in settings/*; do
#     echo "Removing "${FILE}
#     #rm ${FILE}
# done
# echo ""





# mkdir -p $SETTINGS_FOLDER
# for FILE in $TEMPLATE_FOLDER/*; do
#     echo "Loading: "$FILE
#     MASK=${FILE%.template}
#     FILENAME=${MASK##*/}
#     NEWFILE=$SETTINGS_FOLDER/$FILENAME

#     # Checking if previous version of NEWFILE exists
#     if [[ -f "$NEWFILE" ]]
#     then
#       TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`
#       NEWFILEBACKUP=${NEWFILE}.${TIMESTAMP}.backup
#       echo "Backing up old $NEWFILE to $NEWFILEBACKUP"
#       mv $NEWFILE $NEWFILEBACKUP
#     fi
#     echo "Transforming filename from $FILE to $NEWFILE"
#     cp $FILE $NEWFILE
# done
# echo ""

