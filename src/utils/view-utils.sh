#!/bin/bash

source ./src/utils/header-utils.sh
source ./src/utils/io-utils.sh

SYSTEM_INFO_TMP_PATH="./tmp/system-info.tmp"

view_welcome(){
    clear
    print_header
    echo -e "\nWelcome to Menthol - post installation script, that will help you tune your fresh, new system\n"
    read -p "Press enter to continue"
}

view_system_ubuntu(){
    echo "You are running Ubuntu, you can do some things specific for this system:"
    read -p "Press any key to exit" 
}

view_system(){
    clear
    echo -e "System Tuning\n"
    os_type=$(read_value_from_file $SYSTEM_INFO_TMP_PATH DISTRIBUTION =)
    case "$os_type" in
        ubuntu) view_system_ubuntu ;;
          arch) ;;
             *) echo "Sorry, we do not support this system"
                read -p "Press any key to exit"
                exit
                ;;
    esac
}
