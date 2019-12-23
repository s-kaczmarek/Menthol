#!/bin/bash

# This script installs dependencies for grid.sh script

ubuntu_install_winfuncs_dependencies(){
    sudo apt install -y wmctrl xdotool xwininfo xprop sed
}

arch_install_winfuncs_dependencies(){
    sudo pacman -Sy wmctrl xdotool xwininfo xprop sed
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_winfuncs_dependencies
            ;;
    arch)   arch_install_winfuncs_dependencies
            ;;
esac