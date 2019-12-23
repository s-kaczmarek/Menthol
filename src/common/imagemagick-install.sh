#!/bin/bash

# Remember to run this script with argument determinating os type
# TODO - write common method that will check os type for you

ubuntu_install_imagemagick(){
	sudo apt install -y imagemagick
}

arch_install_imagemagick(){
	sudo pacman -Sy imagemagick
}

os_type=$1

case "$os_type" in
	ubuntu)	ubuntu_install_imagemagick
			;;
	arch)	arch_install_imagemagick
			;;
esac
