#!/bin/bash

# TODO:
# - check dependency snap
# - make arch version

skype_install_ubuntu(){
    sudo snap install skype --classic
}

skype_install_arch(){
    # TODO 
}

os_type=$1

case "$os_type" in
    ubuntu) skype_install_ubuntu ;;
      mint) skype_install_ubuntu ;;
      arch) skype_install_arch ;;
esac