#!/bin/bash

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