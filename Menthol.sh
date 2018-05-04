#!/bin/bash

source ./src/Dependencies.sh

clear

#TODO - LOGO

#check if this is first run
if [ ! -e ~/.menthol/menthol.log ]; then
    
    echo -e "\e[0;36mWelcome to Menthol post installation script for Linux Mint!\e[0m"
    echo -e ""
    echo -e "\e[0;36mThis program will guide you through the optimization steps specific\e[0m" 
    echo -e "\e[0;36mfor this distribution. It will also help you to install handy programs,\e[0m" 
    echo -e "\e[0;36msetup automounting of additional drives and restore settings for thunderbird.\e[0m"
    echo -e "\e[0;36mAll of the steps performed with this program are easy to revert or just skip.\e[0m"
    echo -e "\e[0;36mIf you are not sure that you like some of them, simply run this program once again\e[0m"
    echo -e "\e[0;36mand it will show you menu where you can decide which one of them you want to revert\e[0m"
    echo -e "\e[0;36mto defaults.\e[0m"
    echo -e ""
    echo -e "\e[0;36mProgram requires internet connection, please make sure, that computer is connected to\e[0m"
    echo -e "\e[0;36mthe internet and press any key to continue.\e[0m"
    echo -e ""
    read -n1 -r -p "Press any key to continue..." key
    
    #check internet connection
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        first_run_log
        echo -e "\e[0;92mComputer is connected to the internet! We are ready to procede.\e[0m"
        # I BASIC SYTEM SETTINGS
        echo ""
        echo -e "\e[0;36mI. BASIC SYSTEM SETTINGS\e[0m"
        echo ""
        echo -e "\e[0;36mIn this step we will tune system to perform better in case of installing new packages and we will prevent it from using your ssd drive to much, so it will live longer. Remember that all of the steps are easy to revert and you will be able to do so by running this scrip again. For now please follow instructions presented in this wizard.\e[0m"
        echo ""
        echo -e "\e[0;36mIn this part we will make steps presented in the list below:\e[0m"
        # I BASIC SYSTEM SETTINGS - LIST
        echo ""
        echo -e "\e[0;36m    1. Enabling of the recommended packages installation\e[0m"
        echo -e "\e[0;36m    2. Updating installed packages\e[0m"
        echo -e "\e[0;36m    3. Update manager settings\e[0m"
        echo -e "\e[0;36m    4. Driver manager settings\e[0m"
        # Check if multimedia support had been installed during system installation and determinate next step
        PACKAGE_NAME=mint-meta-codecs
        package_existence_control
        if ["$PACKAGE_EXISTENCE" == false] ; then
            echo -e "\e[0;36m    5. Multimedia support\e[0m"
        fi    
        echo -e ""
        read -n1 -r -p "Press any key to continue..." key
        
        
        # Recomended packages installation
        enable_recommended_packages_installation
        update_packages
        update_manager_settings
        driver_manager_settings
        #TODO install only if it wasn't installed previously
        #multimedia_support_install
        
    else
        echo -e "\e[0;31;7mWe have problem with internet connection. Please reconnect and run script again.\e[0m"
    fi
    
    
    
else
    echo "menthol.log does exist" #second run v
fi