#!/bin/bash

ubuntu_install_chromium(){
	sudo apt-get install -y chromium-browser
}

arch_install_chromium(){
	sudo pacman -Sy chromium
}

os_type=$1

case "$os_type" in
	ubuntu)	ubuntu_install_chromium
			;;
	arch)	arch_install_chromium
			;;
esac