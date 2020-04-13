#!/bin/bash

cryfs_install_ubuntu(){
    sudo apt install cryfs
}

cryfs_install_arch(){
    sudo pacman -S cryfs
}

os_type=$1

case "$os_type" in
    ubuntu) cryfs_install_ubuntu ;;
      mint) cryfs_install_ubuntu ;;
      arch) cryfs_install_arch ;;
esac


