#!/bin/bash

LIST_OF_SCRIPTS_TO_EXECUTE="./tmp/to-execute.tmp"

# read_values_from_file()
# returns value assigned to certain key
# pass arguments: file path, key, divider( = or : )
# example: var=$(rad_values_from_file $path GAP =)
read_value_from_file(){
    local file_path=$1
    local key=$2
    local divider=$3

    var=$(cat $file_path | grep "$key" | awk -F"$divider" '{print $2}')
    echo $var
}

source_script_for_execution(){
    echo "entering source_script_for_execution"
    script_name=$1
    script_path=$2
    echo "$script_name" : "$script_path" >> $LIST_OF_SCRIPTS_TO_EXECUTE
}