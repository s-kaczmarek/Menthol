#!/bin/bash

teamviewer_install_ubuntu(){
    sudo dpkg -i ../../resources/local-packages/teamviewer_15.2.2756_amd64.deb
}

# teamviewer_install_arch(){
#     # TODO 
# }

os_type=$1

case "$os_type" in
    ubuntu) teamviewer_install_ubuntu ;;
      mint) teamviewer_install_ubuntu ;;
      arch) teamviewer_install_arch ;;
esac