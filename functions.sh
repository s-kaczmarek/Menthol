#!/bin/bash

# FUNCTIONS

# Recommended packages installation

enable_recommended_packages_installation {

sudo mv -v /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.disabled
# This operation will enable recommended packages installation. You can easyly revert this opperation by changing file name to previous one.

}

disable_recommended_packages_installation {

sudo mv -v /etc/apt/apt.conf.d/00recommends.disabled /etc/apt/apt.conf.d/00recommends
# This operation will disable recommended packages installation. Use it when you decide to keep default linux Mint settings.
echo -e "\e[0;32mrecommended packages installation enabled \e[0m" 

}

# Update packages list & packages

update_packages_list {

sudo apt update
echo -e "\e[0;32mlist of available packages updated \e[0m"

}

update_packages {

sudo apt upgrade
sudo apt dist-upgrade

}

# Update manager settings

update_manager_settings {

echo -e "\e[0;32mNow the update manager will pop up, please change update policy to: -Let me review sensitive updates- and change mirrors for fastest for you. When you finnish, please close update manager and continue \e[0m"
gksudo mintupdate
read -n1 -r -p "Press any key to continue..." key

}

# Drivers

driver_manager_settings {

echo -e "\e[0;32m now the driver manager will pop up, please review if you have any drivers available, enable them if you want, enable microcode (this is optional, recommended only when you have noticed some issues with CPU). If you are being offered several versions of Nvidia drivers, start with number one, and if you notice some issues later on, change to number 2, 3 etc. When finnished, please close update manager and continue \e[0m" 
driver-manager
read -n1 -r -p "Press any key to continue..." key

}

