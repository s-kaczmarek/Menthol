#!/bin/bash

# https://github.com/alacritty/alacritty
# todo - zaimplementuj instalacje dla innych systemów

ubuntu_install_alacritty(){
    sudo add-apt-repository ppa:mmstick76/alacritty
    sudo apt install alacritty
}

arch_install_alacritty(){
    sudo pacman -Sy alacritty
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_alacritty ;;
      mint) ubuntu_install_alacritty ;;
      arch) arch_install_alacritty ;;
esac