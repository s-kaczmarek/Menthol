#!/bin/bash

cryptomator_install_ubuntu(){
    sudo add-apt-repository -y ppa:sebastian-stenzel/cryptomator
    sudo apt-get update
    sudo apt-get install -y cryptomator
}

cryptomator_install_arch(){
    yaourt -S cryptomator --noconfirm
}

os_type=$1

case "$os_type" in
    ubuntu) cryptomator_install_ubuntu ;;
      mint) cryptomator_install_ubuntu ;;
      arch) cryptomator_install_arch ;;
esac
