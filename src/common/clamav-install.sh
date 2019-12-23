#!/bin/bash

ubuntu_install_clamav(){
    sudo apt install -y clamav
}

arch_install_clamav(){
    sudo pacman -Sy clamav
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_clamav ;;
      mint) ubuntu_install_clamav ;;
      arch) arch_install_clamav ;;
esac