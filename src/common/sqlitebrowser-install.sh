#!/bin/bash

# Remember to run this script with argument determinating os type
# TODO - write common method that will check os type for you

ubuntu_install_sqlitebrowser(){
	sudo apt install -y sqlitebrowser
}

arch_install_sqlitebrowser(){
	sudo pacman -Sy sqlitebrowser
}

os_type=$1

case "$os_type" in
	ubuntu)	ubuntu_install_sqlitebrowser
			;;
	arch)	arch_install_sqlitebrowser
			;;
esac
