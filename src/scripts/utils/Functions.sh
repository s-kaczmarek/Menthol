#!/bin/bash

source ./Log.sh

# GLOBAL VARIABLES

TIME=`date '+%d/%m/%Y %H:%M:%S'`
# PACKAGE_NAME variable is needed for creating log entries
PACKAGE_NAME=""
# override this variable when adding new PPA. It will be also used for making log messages
PPA_NAME=""
# override this variable each time you want to add log entry 
MESSAGE=""
# override this variable each time you want to add log entry 
MESSAGE_WARNING=""
# flag for marking to install
TO_INSTALL_FLAG = false 


# FUNCTIONS

## REMEMBER TO DELETE ALL #TEST (this comment turns off functions in order not to mess with computer during tests)

## GLOBAL FUNCTIONS



package_existence_control() {

    # WARNING! This function will be called by "package_installation" function. Don't use it on it's own!
    # This function is made to set value of TO_INSTALL_FLAG to true or false depending on the existence of
    # package that we want to check. Use this variable as a flag to determinate weather install package or not.
    # Remember to determinate variable "PACKAGE_NAME" for purpose of passing package name to log file
    # and also to pass its name as $1 argument. Example: package_existence_control $PACKAGE_NAME
    # PKG_OK variable will get return value from dpkg-query "install ok installed" if package from variable PACKAGE_NAME exists
    
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 |grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        MESSAGE="Package $1 does not exists!"
        echo -e "\e[0;31m$MESSAGE\e[0m"
        #log_entry TODO not sure if log entry should be performed by this function
        TO_INSTALL_FLAG=true
        PACKAGE_EXISTENCE=false
    else
        MESSAGE="Package $1 exists!"
        echo -e "\e[0;92m$MESSAGE\e[0m"
        #log_entry TODO not sure if log entry should be performed by this function
        PACKAGE_EXISTENCE=true
    fi

}

package_installation() {

    # use this function to install packages from repository
    # pass $PACKAGE NAME as $1 argument example: package_installation $PACKAGE_NAME

    # First check if package is realy missing:

    package_existence_control $PACKAGE_NAME

    # package_existence_control will give you value of $PACKAGE_EXISTENCE and $TO_INSTALL_FLAG which will determinate weather install package or not
 
    if [ $PACKAGE_EXISTENCE  == false ] && [ $TO_INSTALL_FLAG == true ]; then  
        sudo apt-get --force-yes --yes install $1
        # TODO create method to check if package was installed correctly 
        package_existence_control $PACKAGE_NAME
        if [ $PACKAGE_EXISTENCE  == true ]; then
            MESSAGE="$PACKAGE_NAME installed successfully"
            log_entry
        else
            MESSAGE_WARNING="$PACKAGE_NAME not installed"
            log_entry_warning    
        fi
    else
        echo -e "ERROR"
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

jetbrains_toolbox_install() {
    PACKAGE_NAME=jetbrains-toolbox
    if [ "$TO_INSTALL_FLAG" = true ] ; then
        MESSAGE="Installing $PACKAGE_NAME"
        echo -e "\e[0;92m$MESSAGE\e[0m"
        log_entry
        #TODO 
        #wget http://path/to/package/store(maybe dropbox) (zapisz w ~/Downloads)
        sudo cp -v ~/Downloads/jetbrains-toolbox-*.tar.gz /opt
        sudo tar -xzf /opt/jetbrains-toolbox-*.tar.gz
        sudo rm -v /opt/jetbrains-toolbox-*.tar.gz
        package_existence_control #TODO zrób lokalną metodę, to nie jest instalowane przez manager pakietów
        nemo /opt/jetbrains-toolbox* #odpalenie nemo, żeby sobie odpalić ten dziwny plik ręcznie
        #TODO instrukcja o uruchomieniu toolboxa i instalacji ręcznej idea i innych, pausa dapóki klient nie ogarnie sobie tematu przez toolboxa
    fi
}
