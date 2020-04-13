#!/bin/bash

tomb_install_ubuntu(){
    sudo apt install tomb
}

tomb_install_arch(){
    yaourt -S tomb --noconfirm
}

os_type=$1

case "$os_type" in
    ubuntu) tomb_install_ubuntu ;;
      mint) tomb_install_ubuntu ;;
      arch) tomb_install_arch ;;
esac