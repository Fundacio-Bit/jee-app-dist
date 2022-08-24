#!/bin/bash

#set -o nounset
#set -o errexit

#### Description: Test for string values
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   Test environment values   ###
###################################

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Testing string utils..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh 

foobar=foo-bar
echo Testing $foobar in spinal-case format
echo ""
echo To lowercase
echo $(lib_string_utils.spinal_to_lower $foobar)
echo ""
echo To uppercase
echo $(lib_string_utils.spinal_to_upper $foobar)
echo ""
echo To camelcase
echo $(lib_string_utils.spinal_to_camelcase $foobar)

echo ""
foobar=$PROJECT_PATH/test/foobar.txt
echo "FOO=bar" > $foobar
echo File $foobar created
echo Listing $foobar
cat $foobar
echo ""
lib_string_utils.replace_key_value FOO bar foo $foobar
echo ""
echo Listing $foobar
cat $foobar
echo Deleting $foobar
rm $foobar
echo ""


