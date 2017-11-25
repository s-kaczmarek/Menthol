#!/bin/bash

clear

#LOGO

#check if this is first run
if [ ! -e ~/.menthol/menthol.log ]; then
    
    echo -e "\e[0;36mWelcome to Menthol post installation script for Linux Mint!\e[0m"
    echo -e ""
    echo -e "\e[0;36mThis program will guide you through the optimization steps specific\e[0m" 
    echo -e "\e[0;36mfor this distribution. It will also help you to install handy programs,\e[0m" 
    echo -e "\e[0;36msetup automounting of additional drives and restore settings for thunderbird.\e[0m"
    echo -e "\e[0;36mAll of the steps performed with this program are easy to revert or just skip.\e[0m"
    echo -e "\e[0;36mIf you are not sure that you like some of them, simply run this program once again\e[0m"
    echo -e "\e[0;36mand it will show you menu where you can decide which one of them you want to revert to defaults.\e[0m"
    echo -e ""
    echo -e "\e[0;36mProgram requires internet connection, please make sure, that computer is connected to the internet and press any key to continue.\e[0m"
    echo -e ""
    read -n1 -r -p "Press any key to continue..." key
    
    #check internet connection
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        echo "\e[0;36mComputer is connected to the internet!\e[0m"
    else
        echo "\e[0;31mWe have problem with internet connection. Please reconnect and run script again.\e[0m"
    fi
    
    
    
else
    echo "menthol.log does exist"
fi