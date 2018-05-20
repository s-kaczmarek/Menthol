#!/bin/bash

source ../utils/Functions.sh
source ../utils/Log.sh

paper-theme_install() {

    # try to store package names in array
    PPA_NAME="ppa:snwh/pulp"
    PACKAGE_NAME="paper-icon-theme"
    sudo add-apt-repository $PPA_NAME
    sudo apt update
    package_installation $PACKAGE_NAME
    PACKAGE_NAME="paper-cursor-theme"
    package_installation $PACKAGE_NAME
    PACKAGE_NAME="paper-gtk-theme"
}


papyrus-icon-theme_install() {

    PPA_NAME="ppa:papirus/papirus"
    PACKAGE_NAME="papirus-icon-theme"
    sudo add-apt-repository $PPA_NAME
    sudo apt update
    package_installation $PACKAGE_NAME

}

hardcode-tray-fixer_install() {
    sudo add-apt-repository ppa:andreas-angerer89/sni-qt-patched
    sudo apt update
    sudo apt install sni-qt sni-qt:i386 hardcode-tray
}

folder-color_install() {
    sudo add-apt-repository ppa:costales/folder-color
    sudo apt-get update
    sudo apt-get install folder-color-nemo
    nemo -q
}