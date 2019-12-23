#!/bin/bash

# This script installs dependencies for twily - pseudo tile scripts

ubuntu_install_twily_dependencies(){
    sudo apt install -y wmctrl xdotool xwininfo xprop sed
}

arch_install_twily_dependencies(){
    sudo pacman -Sy wmctrl xdotool xwininfo xprop sed
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_twily_dependencies
            ;;
    arch)   arch_install_twily_dependencies
            ;;
esac