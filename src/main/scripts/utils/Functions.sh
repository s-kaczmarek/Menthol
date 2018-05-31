#!/bin/bash

source ../utils/Log.sh
source ../utils/Paths.sh
source ../utils/ColorPalette.sh

# GLOBAL VARIABLES

# Time format
TIME=`date '+%d/%m/%Y %H:%M:%S'`

# PACKAGE_NAME variable is needed for creating log entries
PACKAGE_NAME=""

# override this variable when adding new PPA. It will be also used for making log messages
PPA_NAME=""

# override this variable to check if PPA exists
PPA_URL=""

# flag for marking to add ppa
ADD_PPA_FLAG=false

# override this variable each time you want to add log entry 
MESSAGE=""

# override this variable each time you want to add log entry 
MESSAGE_WARNING=""

# flag for marking to install
TO_INSTALL_FLAG=false

# override this variable each time you want to install something from external source
URL=""


# FUNCTIONS

## REMEMBER TO DELETE ALL #TEST (this comment turns off functions in order not to mess with computer during tests)

## GLOBAL FUNCTIONS



package_existence_control() {

    # WARNING! This function will be called by "package_installation" function. Don't use it on it's own!

    # This function is made to set value of TO_INSTALL_FLAG to true or false depending on the existence of
    # package that we want to check. Use this variable as a flag to determinate weather install package or not.

    # Remember to determinate variable "PACKAGE_NAME" for purpose of passing package name to log file
    # and also to pass its name as $2 argument.

    # Example: package_existence_control $PACKAGE_NAME

    # PKG_OK variable will get return value from dpkg-query "install ok installed" if package from variable PACKAGE_NAME exists
    
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 |grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        PACKAGE_EXISTENCE=false
        TO_INSTALL_FLAG=true
    else
        PACKAGE_EXISTENCE=true
        TO_INSTALL_FLAG=false
    fi
    

}

package_existence_control_none-repository() {

    # WARNING! This function will be called by "package_installation_from_url" function. Don't use it on it's own!
    # This function is made to set value of TO_INSTALL_FLAG to true or false depending on the existence of
    # package that we want to check. Use this variable as a flag to determinate weather install package or not.

    # Remember to determinate variable "PACKAGE_NAME" (in this case "PACKAGE_NAME" is the name of folder that will be
    # placed in /opt derectory) for purpose of passing package name to log file and also to pass its name as
    # $1 argument. Example: package_existence_control_none-repository $PACKAGE_NAME.

    if [ ! -d "$PATH_TO_OPT/$PACKAGE_NAME" ]; then
        MESSAGE="Package $1 does not exists! Performing installation process"
        PACKAGE_EXISTENCE=false
        TO_INSTALL_FLAG=true
        echo_message $MESSAGE
        log_entry
    else
        MESSAGE="Package $1 exists! Aborting installation process"
        echo_message_warning $MESSAGE
        log_entry_warning
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

package_installation() {

    # use this function to install packages from repository
    # this function is also responsible for messages and logs
    # pass $PACKAGE NAME as $1 argument 
    # example: package_installation $PACKAGE_NAME

    # First check if package is realy missing:

    package_existence_control $1

    # package_existence_control will give you value of $PACKAGE_EXISTENCE and $TO_INSTALL_FLAG which will determinate 
    # weather install package or not
 
    if [ $PACKAGE_EXISTENCE  == false ] && [ $TO_INSTALL_FLAG == true ]; then
        MESSAGE="Package does not exist, performing installation..."
        echo_message $MESSAGE
        sudo apt-get --force-yes --yes install $1
        package_existence_control $1
        if [ $PACKAGE_EXISTENCE  == true ] && [ $TO_INSTALL_FLAG == false ]; then
            MESSAGE="$1 installed successfully!"
            echo_message $MESSAGE
            log_entry $MESSAGE
        else
            MESSAGE_ERROR="$1 not installed!"
            echo_message_error $MESSAGE_ERROR
            log_entry_error $MESSAGE_ERROR
        fi
    else
        MESSAGE_WARNING="Package already installed!"
        echo_message_warning $MESSAGE_WARNING
        log_entry_warning $MESSAGE_WARNING
    fi        

}

package_installation_from_url() {

    # TODO: test whole function!

    # Use this function to install programs that need to be downloaded from their original source,
    # (like: Postman, JetBrains Toolbox). All packages installed this way will be installed in /opt

    package_existence_control_none-repository $PACKAGE_NAME

    if [ $PACKAGE_EXISTENCE  == false ] && [ $TO_INSTALL_FLAG == true ]; then
        cd $PATH_TO_DOWNLOADS
        wget -O ${PACKAGE_NAME_ARCHIVE} ${URL}
        mkdir ${PACKAGE_NAME}
        if [ ${file: -7} == ".tar.gz" ]; then
            tar -xvzf ${PACKAGE_NAME_ARCHIVE} -C ${PACKAGE_NAME}
        elif [ ${file: -4} == ".zip" ]; then
            # TODO: We need unzip to do that, so now we have to check if uzip is installed and if not - install it.
            # TODO: conssider using dependency check function to do that.
            package_installation unzip
            unzip ${PACKAGE_NAME_ARCHIVE} -d ${PACKAGE_NAME}
        fi
        mv -v ${PACKAGE_NAME} /opt
        # TODO: odpalenie w osobnym procesie (To prawdopodobnie będzie robione przez osobną funkcję)
        # ponizej propozycja do przetestowania.
        /opt/PACKAGE_NAME/TO_RUN_FILE_NAME & 
    fi

}

## Recommended packages installation

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

## Update packages list & packages

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

default_update_manager_settings() {
    TODO
}

# Drivers

driver_manager_settings() {

    echo -e "\e[0;32m now the driver manager will pop up, please review if you have any drivers available, enable them if you want, enable microcode (this is optional, recommended only when you have noticed some issues with CPU). If you are being offered several versions of Nvidia drivers, start with number one, and if you notice some issues later on, change to number 2, 3 etc. When finnished, please close update manager and continue \e[0m" 
    driver-manager
    read -n1 -r -p "Press any key to continue..." key

}

default_driver_manager_settings() {
    TODO
}

multimedia_support_install() {

    PACKAGE_NAME=mint-meta-codecs
    if [ "$TO_INSTALL_FLAG" = true ] ; then
        MESSAGE="Installing multimedia support - $PACKAGE_NAME"
        echo -e "\e[0;92m$MESSAGE\e[0m"
        log_entry
        sudo apt-get --force-yes --yes install $PACKAGE_NAME
        package_existence_control
    fi

}

