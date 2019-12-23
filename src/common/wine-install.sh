#!/bin/bash

# FUNCTIONS

add_key(){
	cd ../../tmp
	sudo dpkg --add-architecture i386 &&
	wget -nc https://dl.winehq.org/wine-builds/winehq.key &&
	sudo apt-key add winehq.key
}

install_wine_mint(){
	add_key
	mint_version=19 # currently version is hardcoded, TODO make function, that will return version
	case "mint_version" in
		19) sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' ;;
		 *) echo "You have to provide information about LinuxMint version" ;;
	esac

	sudo apt-get update &&
	sudo apt-get install --install-recommends winehq-stable &&
	sudo apt install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386
}

install_wine_ubuntu(){
	add_key
	ubuntu_version=19.04 # currently version is hardcoded, TODO make function, that will return version
	case "$ubuntu_version" in
		19.04) sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main' ;;
			*) echo "Something is wrong with information about os version..." ;;
	esact

	sudo apt-get update &&
	sudo apt-get install --install-recommends winehq-stable &&

	# TODO - if you get error:
	# The following packages have unmet dependencies
	# execute:
	# sudo apt-get install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64

	# Install additional packages frequently required by games, launchers etc.

	sudo apt install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386
}

install_wine_arch(){

	# https://github.com/lutris/lutris/wiki/Wine-Dependencies

	# TODO - uncomment [multilib section] in /etc/pacman.conf
	echo "Making multilib available..."

	sudo pacman -Syu &&
	sudo pacman -S wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
}

# SCRIPT

os_type=$1

case "$os_type" in
	  mint) install_wine_mint ;;
	ubuntu)	install_wine_ubuntu ;;
	  arch)	install_wine_arch ;;
esac