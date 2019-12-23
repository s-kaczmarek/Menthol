#!/bin/bash

ubuntu_install_youtube-dl(){
    sudo apt install youtube-dl -y
}

arch_install_youtube-dl(){
    sudo pacman -Sy youtube-dl
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_youtube-dl
            ;;
    arch)   arch_install_youtube-dl
            ;;
esac