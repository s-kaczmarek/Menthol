#!/bin/bash

# GLOBAL VARIABLES

TIME=`date '+%d/%m/%Y %H:%M:%S'`
MESSAGE=""  # override this variable each time you want to add log entry  

# FUNCTIONS

### REMEMBER TO DELETE ALL #TEST

# Recommended packages installation

first_run_log() {

    touch ~/.menthol/log/menthol.log
    #time=`date '+%d/%m/%Y %H:%M:%S'`
    echo "$TIME - FIRST RUN" >> ~/.menthol/log/menthol.log

}

log_entry() {

    echo "$TIME - $MESSAGE" >> ~/.menthol/log/menthol.log

}

control_file() {    #try to pass file nam as argument of function
    touch ~/.menthol/log/control_files/"$FILE_NAME"
}

enable_recommended_packages_installation() {

    echo -e "\e[0;36m1. Enable installation of Recommended packages.\e[0m"
    echo -e ""
    echo -e "\e[0;36mRecommended packages are additional packages that are sometimes very important for newly installed programs to work. Linux Mint by default does not install additional packages as Ubuntu does. In some some situations it may endup with not working program that you already installed\e[0m" #TODO work on this description
    echo -e ""
    echo -e "\e[0;36mWould you like to procede? [y/n]\e[0m"

    while read y_n; do
        case "$y_n" in
         [Yy]* ) #TEST sudo mv -v /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.disabled
                 # This operation will enable recommended packages installation. You can easyly revert this opperation by changing file name to previous one.
                 MESSAGE="Recommended packages installation enabled!"
                 echo -e "\e[0;92m$MESSAGE\e[0m"
                 log_entry
                 break ;;                                                                              
         [Nn]* ) MESSAGE="Recommended packages installation skipped"
                 echo -e "\e[0;92m$MESSAGE\e[0m"
                 log_entry
                 break ;;  
              *) echo -e "\e[0;31m Wrong input! Type y or n \e[0m" ;        
        esac
    done

}

disable_recommended_packages_installation() {

    sudo mv -v /etc/apt/apt.conf.d/00recommends.disabled /etc/apt/apt.conf.d/00recommends
    # This operation will disable recommended packages installation. Use it when you decide to keep default linux Mint settings.
    echo -e "\e[0;32mrecommended packages installation enabled \e[0m" 

}

# Update packages list & packages

update_packages() {

    echo -e "\e[0;36m2. Updating installed packages.\e[0m"
    echo -e ""
    echo -e "\e[0;36mNow we will simply update all installed programs.\e[0m"
    read -n1 -r -p "Press any key to continue..." key

    sudo apt update
    MESSAGE="List of available packages updated!"
    echo -e "\e[0;92m$MESSAGE\e[0m"
    log_entry
    sudo apt upgrade
    sudo apt dist-upgrade
    MESSAGE="Packages updated!"
    echo -e "\e[0;92m$MESSAGE\e[0m"
    log_entry

}

# Update manager settings

update_manager_settings() {

    echo -e "\e[0;32mNow the update manager will pop up, please change update policy to: -Let me review sensitive updates- and change mirrors for fastest for you. When you finnish, please close update manager and continue \e[0m"
    gksudo mintupdate
    read -n1 -r -p "Press any key to continue..." key

}

# Drivers

driver_manager_settings() {

    echo -e "\e[0;32m now the driver manager will pop up, please review if you have any drivers available, enable them if you want, enable microcode (this is optional, recommended only when you have noticed some issues with CPU). If you are being offered several versions of Nvidia drivers, start with number one, and if you notice some issues later on, change to number 2, 3 etc. When finnished, please close update manager and continue \e[0m" 
    driver-manager
    read -n1 -r -p "Press any key to continue..." key

}

