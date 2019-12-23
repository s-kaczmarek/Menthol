#!/bin/bash

PATH_TO_MEGA_ISTALL_FOLDER=../resources/mega

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

fix_broken_install(){
    if [ $? -ne 0 ]; then
        echo "some problems occurred during installation, we are trying to fix that..."
        sudo apt --fix-broken install
    fi
}

# Installation of megasync
package_existence_control megasync
if [ $PACKAGE_EXISTENCE  == false ]; then
    echo "installing MEGAsync..."
    sudo apt install -y $PATH_TO_MEGA_ISTALL_FOLDER/megasync-xUbuntu*.deb
    fix_broken_install
else
    echo "MEGAsync is already installed, are you sure, that you want to install another version? Choose 1 or 2."
    select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo apt install -y $PATH_TO_MEGA_ISTALL_FOLDER/megasync-xUbuntu*.deb; fix_broken_install; break;;
        No ) break;;
    esac
done
fi

# Installation of dolphin integration
package_existence_control dolphin
if [ $PACKAGE_EXISTENCE  == true ]; then
    package_existence_control dolphin-megasync
    if [ $PACKAGE_EXISTENCE  == false ]; then
        echo "installing Dolphin integration..."
        sudo apt install -y $PATH_TO_MEGA_ISTALL_FOLDER/dolphin-megasync*.deb
        fix_broken_install
    else
        echo "Dolphin integration is already installed, do you want to reinstall?"
        select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo apt install -y $PATH_TO_MEGA_ISTALL_FOLDER/dolphin-megasync*.deb; fix_broken_install; break;;
            No ) break;;
        esac
    done
    fi
fi

# Installation of nautilus integration
package_existence_control nautilus
if [ $PACKAGE_EXISTENCE  == true ]; then
    package_existence_control nautilus-megasync
    if [ $PACKAGE_EXISTENCE  == false ]; then
        echo "installing Dolphin integration..."
        sudo apt install -y $PATH_TO_MEGA_ISTALL_FOLDER/nautilus-megasync*.deb
        fix_broken_install
    else
        echo "Dolphin integration is already installed, do you want to reinstall?"
        select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo apt install -y $PATH_TO_MEGA_ISTALL_FOLDER/nautilus-megasync*.deb; fix_broken_install; break;;
            No ) break;;
        esac
    done
    fi
fi

