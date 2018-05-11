#!/bin/bash

source ../utils/Functions.sh
source ../utils/Log.sh

node_js_install() {

    PACKAGE_NAME="audio-recorder"
    PPA_NAME="ppa:audio-recorder/ppa"
    sudo add-apt-repository $PPA_NAME
    sudo apt update
    package_installation $PACKAGE_NAME

}