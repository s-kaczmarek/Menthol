#!/bin/bash

source ./src/utils/io-utils.sh

PATH_TO_GLOBAL_VARIABLES=./global-variables
LIST_OF_SCRIPTS_TO_EXECUTE=$(read_value_from_file $PATH_TO_GLOBAL_VARIABLES LIST_OF_SCRIPTS_TO_EXECUTE =)

execute_scripts_from_file(){
    while read p; do
        echo "$p"
    done < $LIST_OF_SCRIPTS_TO_EXECUTE
}

execute_scripts_from_file
read -p "Press enter to continue"