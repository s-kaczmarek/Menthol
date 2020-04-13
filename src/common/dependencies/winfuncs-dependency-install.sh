#!/bin/bash

# This script installs dependencies for winfuncs.sh script

ubuntu_install_winfuncs_dependencies(){
    sudo apt install -y xwininfo wmctrl xdotool
}

arch_install_winfuncs_dependencies(){
    sudo pacman -Sy xwininfo wmctrl xdotool
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_winfuncs_dependencies
            ;;
    arch)   arch_install_winfuncs_dependencies
            ;;
esac