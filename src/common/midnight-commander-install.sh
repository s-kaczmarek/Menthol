#!/bin/bash

ubuntu_install_mc(){
    sudo apt install -y mc
}

arch_install_mc(){
    sudo pacman -Sy mc
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_mc
            ;;
    arch)   arch_install_mc
            ;;
esac