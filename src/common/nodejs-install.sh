#!/bin/bash

ubuntu_install_nodejs(){
	# curl is dependency
	sudo apt install curl &&
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - 
	sudo apt-get install -y nodejs
}

arch_install_nodejs(){
	sudo pacman -Sy nodejs &&
	sudo pacman -Sy npm &&
}

os_type=$1

case "$os_type" in
	ubuntu)	ubuntu_install_nodejs
			;;
	arch)	arch_install_nodejs
			;;
esac