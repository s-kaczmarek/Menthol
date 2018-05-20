#!/bin/bash

source ../utils/Functions.sh
source ../utils/Log.sh

# GCONF

gconf-editor_install() {

    PACKAGE_NAME="gconf-editor"
    package_installation $PACKAGE_NAME

}

