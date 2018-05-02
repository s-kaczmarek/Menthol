#!/bin/bash

source ../utils/Functions.sh
source ../utils/Log.sh

# NODE JS

node_js_install() {

    PACKAGE_NAME="nodejs-legacy"
    package_installation $PACKAGE_NAME
    PACKAGE_NAME="npm"
    package_installation $PACKAGE_NAME

}

node_js_install