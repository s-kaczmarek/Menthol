#!/bin/bash

source ../utils/Log.sh
source ../utils/ColorPalette.sh

# https://itsfoss.com/reduce-overheating-laptops-linux/
# https://wiki.archlinux.org/index.php/TLP
# https://linrunner.de/en/tlp/tlp.html

package_existence_control() {

    # This function is made to set value of PACKAGE_EXISTENCE to true or false depending on the existence of
    # package that we want to check. Use this variable as a flag to determinate weather install package or not.

    # pass name of the package as $1 argument
    # Example: package_existence_control $PACKAGE_NAME

    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 |grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        PACKAGE_EXISTENCE=false
    else
        PACKAGE_EXISTENCE=true
    fi
}

ppa_existence_control() {

    # WARNING! This function will be called by "package_installation_from_ppa" function. Don't use it on it's own!
    # This function is made to set value of ADD_PPA_FLAG to true or false depending on the existence of
    # ppa that we want to check. Use this variable as a flag to determinate weather add ppa or not.

    # Remember to determinate variable "PPA_NAME" (in this case "PPA_NAME" is the part of the name we are looking 
    # for in both /etc/apt/source.list.d directory or /etc/apt/sources file) for purpose of passing ppa name 
    # to log file and also to pass its name as $1 argument. 
    # Example: ppa_existence_control $PPA_URL.

    if ! grep -q "^deb .*$1" /etc/apt/sources.list /etc/apt/sources.list.d/* ; then
        MESSAGE="$1 does not exists! Adding PPA..."
        PPA_EXISTENCE=false
        ADD_PPA_FLAG=true
        echo_message $MESSAGE
        log_entry $MESSAGE
    else
        MESSAGE_WARNING="PPA $1 exists! Aborting adding process"
        PPA_EXISTENCE=true
        ADD_PPA_FLAG=false
        echo_message_warning $MESSAGE_WARNING
        log_entry_warning $MESSAGE_WARNING
    fi
}

package_installation_from_ppa() {

    # Use this function if you want to install package from ppa
    # Pass PACKAGE_NAME as $1 argument and PPA_NAME as $2 argument and PPA_URL as $3 argument
    # Example: package_installation_from_ppa $PACKAGE_NAME $PPA_NAME $PPA_URL

    package_existence_control $1 # PACKAGE_NAME

    if [ $PACKAGE_EXISTENCE  == false ] && [ $TO_INSTALL_FLAG == true ]; then
        MESSAGE="$1 does not exists, performing installation process"
        echo_message $MESSAGE
        log_entry $MESSAGE
        ppa_existence_control $3 # PPA_URL
        if [ $PPA_EXISTENCE == false ] && [ $ADD_PPA_FLAG == true ]; then
            sudo add-apt-repository $PPA_NAME --yes
            sudo apt update
            ppa_existence_control $3
            if [ $PPA_EXISTENCE == true ] && [ $ADD_PPA_FLAG == false ]; then
                package_installation $1
            fi
        elif [ $PPA_EXISTENCE == true ] && [ $ADD_PPA_FLAG == false ]; then
            package_installation $1
        fi
    else
        MESSAGE_WARNING="Package already installed!"
        echo_message_warning $MESSAGE_WARNING
        log_entry_warning $MESSAGE_WARNING
    fi

}

echo_message "=================="
echo_message "= Installing TLC ="
echo_message "=================="
echo_message "TLC is a daemon, that will reduce battery consumption and laptop overheating"

# Check if this is desktop or laptop
CHASSIS_TYPE=$(sudo dmidecode --string chassis-type)
if [ "Desktop" != "$CHASSIS_TYPE" ]; then
    # If computer is not desktop, add TLP PPA and install TPL base:
    sudo add-apt-repository -y ppa:linrunner/tlp
    sudo apt-get update
    sudo apt-get install tlp tlp-rdw
    # Check if laptop is Thinkpad (TODO not sure if this solution is reliable)
    LAPTOP_MANUFACTURER=$(sudo dmidecode -s chassis-manufacturer)
    if [ "LENOVO" == "$LAPTOP_MANUFACTURER" ]; then
        echo_message "You are working on LENOVO laptop, so we will install additional packages..."
        sudo apt-get install tp-smapi-dkms acpi-call-dkms
    fi
    echo_message "TLP requires rebooting to make it work! Please reboot system once you finish installing everything"
else
    echo_message "You are working on Desktop PC, there is no need to install TLP"
fi