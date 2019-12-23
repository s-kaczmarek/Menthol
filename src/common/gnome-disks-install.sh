#!/bin/bash

ubuntu_install_gnome-disks(){
    sudo apt-get install -y gnome-disk-utility
}

arch_install_gnome-disks(){
    # TODO
}

os_type=$1

case "$os_type" in
    ubuntu) ubuntu_install_gnome-disks
            ;;
    arch)   arch_install_gnome-disks
            ;;
esac