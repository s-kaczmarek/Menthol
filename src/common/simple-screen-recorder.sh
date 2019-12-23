#!/bin/bash

ubuntu_install_simplescreenrecorder(){
    sudo apt install simplescreenrecorder -y
}

arch_install_simplescreenrecorder(){
    sudo pacman -Sy simplescreenrecorder
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_simplescreenrecorder ;;
      mint) ubuntu_install_simplescreenrecorder ;;
      arch) arch_install_simplescreenrecorder ;;
esac