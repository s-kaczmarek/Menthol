#!/bin/bash

source ../utils/Functions.sh
source ../utils/Log.sh

audio-recorder_install() {

    PACKAGE_NAME="audio-recorder"
    PPA_NAME="ppa:audio-recorder/ppa"
    sudo add-apt-repository $PPA_NAME
    sudo apt update
    package_installation $PACKAGE_NAME

}

audacity_install() {

    PACKAGE_NAME="audacity"
    package_installation $PACKAGE_NAME

}

mpd_install() {

	# https://ubuntu-mate.community/t/how-to-install-and-setup-mpd-mpdscribble-ncmpcpp/8439
 
    PACKAGE_NAME="mpd"
    sudo apt update
    package_installation $PACKAGE_NAME

    ## TODO Read tutorial how to install mpd and setting for it.  


}

ncmpcpp_install() {

	# # https://ubuntu-mate.community/t/how-to-install-and-setup-mpd-mpdscribble-ncmpcpp/8439
	# TODO read tutorial how to install ncmpcpp

}
