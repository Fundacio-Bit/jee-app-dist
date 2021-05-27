#!/bin/bash
#### Description: Creates custom settings files from template
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

TEMPLATE_FOLDER=settings.template.d
SETTINGS_FOLDER=settings

mkdir -p $SETTINGS_FOLDER
for FILE in $TEMPLATE_FOLDER/*; do
    echo "Loading: "$FILE
    MASK=${FILE%.template}
    FILENAME=${MASK##*/}
    NEWFILE=$SETTINGS_FOLDER/$FILENAME
    echo "Transforming filename from $FILE to $NEWFILE"
    cp $FILE $NEWFILE
done
echo ""

