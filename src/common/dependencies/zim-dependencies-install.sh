#!/bin/bash

ubuntu_install_zim_dependencies(){
    sudo apt install -y python3-gtkspellcheck
    sudo apt install -y gir1.2-gtkspell3-3.0
    sudo pip seqdiag
}

arch_install_zim_dependancies(){
    sudo pacman -Sy  sudo apt install python-gtkspellcheck
    sudo pacman -Sy  sudo apt install python-seqdiag
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_zim_dependencies ;;
      mint) ubuntu_install_zim_dependencies ;;
      arch) arch_install_zim_dependancies ;;
esac