#!/bin/bash

source ../utils/Functions.sh

# UNZIP

unzip_install() {

    PACKAGE_NAME="unzip"
    # TODO: PACKAGE_DESCRIPTION
    package_installation $PACKAGE_NAME

}

# GCONF

gconf-editor_install() {

    PACKAGE_NAME="gconf-editor"
    # TODO: PACKAGE_DESCRIPTION
    package_installation $PACKAGE_NAME

}

# TLP

tlp_install() {

    # https://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html#installation
    PPA_NAME="ppa:linrunner/tlp"
    PPA_URL="http://ppa.launchpad.net/linrunner/tlp/ubuntu"
    PACKAGE_NAME="tlp"
    PACKAGE_DESCRIPTION="TLP is a tool that improves power management on Linux"
    package_installation_from_ppa $PACKAGE_NAME $PPA_NAME $PPA_URL

    #TODO: check if computer is thinkpad. If yes, then install: sudo apt-get install tp-smapi-dkms acpi-call-dkms

}



