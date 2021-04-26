#!/bin/bash
#### Description: Creates an .env file from xx_XXenv files in alpabethical order
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   SETUP UTILS         ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Setting .env file..."
echo ""

touch .environment
for FILE in settings/[0-9]*; do
    echo "Loading: "$FILE
    echo $'\n' >> .environment
    cat $FILE >> .environment
done
echo ""
mv .environment .env
