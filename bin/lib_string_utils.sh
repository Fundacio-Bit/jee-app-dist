#!/bin/bash

#set -o nounset
#set -o errexit

#### Description: String utils function library
#### Written by: Guillermo de Ignacio - gdeignacio@fundaciobit.org on 04-2021

###################################
###   STRING UTILS              ###
###################################

lib_string_utils.spinal_to_camelcase() {
    IFS=- read -ra str <<<"$1"
    printf '%s' "${str[@]^}"
}

lib_string_utils.spinal_to_lower() {
    IFS=- read -ra str <<<"$1"
    printf '%s' "${str[@],,}"
}

lib_string_utils.spinal_to_upper() {
    IFS=- read -ra str <<<"$1"
    printf '%s' "${str[@]^^}"
}

lib_string_utils.replace_key_value(){
    
    local key=$1
    local old_value=$2
    local new_value=$3
    local file=$4

    old_key_value=$(echo $key\=$old_value)
    new_key_value=$(echo $key\=$new_value)
    echo "Value substitution from $old_key_value to $new_key_value"
    # Better use double quoting for sedstring'
    sed -i "s/${old_key_value}/${new_key_value}/" ${file}
}

lib_string_utils.encode_base64() {
    echo -n "$1" | base64
}

lib_string_utils.decode_base64() {
    echo "$1" | base64 --decode
}

echo ""
echo lib_string_utils.sh loaded
echo ""