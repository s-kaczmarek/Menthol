#!/bin/bash

ubuntu_install_ranger(){
    sudo apt install -y ranger
}

arch_install_ranger(){
    sudo pacman -Sy ranger
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_ranger ;;
      mint) ubuntu_install_ranger ;;
      arch) arch_install_ranger ;;
esac