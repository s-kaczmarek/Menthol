#!/bin/bash

# Remember to run this script with argument determinating os type
# TODO - write common method that will check os type for you

#https://lutris.net/downloads/

ubuntu_install_lutris(){
	sudo add-apt-repository -y ppa:lutris-team/lutris &&
	sudo apt-get update &&
	sudo apt-get install -y lutris
}

arch_install_lutris(){
	sudo pacman -Sy lutris
}

os_type=$1

case "$os_type" in
	ubuntu)	ubuntu_install_lutris
			echo "Installing wine dependencies..."
			./wine-install.sh ubuntu
			;;
	arch)	arch_install_lutris
			echo "Installing wine dependencies..."
			./wine-install.sh arch
			;;
esac
