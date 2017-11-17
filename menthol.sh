#!/bin/bash

clear

#LOGO

#check if this is first run
if [ ! -e ~/.menthol/menthol.log ]; then
    
    echo -e "\e[0;36mWelcome to Menthol post installation script for Linux Mint!\e[0m"
    echo -e ""
    echo -e "\e[0;36mThis program will guide you through the optimization steps specific for this distribution.\e[0m" 
    echo -e "\e[0;36mIt will also help you to install handy programs, setup automounting of additional drives and restore settings for thunderbird.\e[0m"
    echo -e "\e[0;36mAll of the steps performed with this program are easy to revert or just skip. If you are not sure that you like some of them,\e[0m"
    echo -e "\e[0;36msimply run this program once again and it will show you menu where you can decide which one of them you want to revert to defaults.\e[0m"
    echo -e ""

else
    echo "menthol.lox does exist"
fi