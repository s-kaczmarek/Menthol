#!/bin/bash

ubuntu_install_cmatrix(){
    sudo apt install -y cmatrix
}

arch_install_cmatrix(){
    sudo pacman -Sy cmatrix
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_cmatrix ;;
      mint) ubuntu_install_cmatrix ;;
      arch) arch_install_cmatrix ;;
esac