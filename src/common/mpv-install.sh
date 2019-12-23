#!/bin/bash

ubuntu_install_mpv(){
    sudo apt install -y mpv
}

arch_install_mpv(){
    sudo pacman -Sy mpv
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_mpv
            ;;
    arch)   arch_install_mpv
            ;;
esac