#!/bin/bash

source ../utils/Functions.sh
source ../utils/Log.sh

# SUBLIME TEXT

sublime-text3_install() {

    PACKAGE_NAME="sublime-text"
    package_installation $PACKAGE_NAME

}

# NODE JS

node_js_install() {

    PACKAGE_NAME="nodejs-legacy"
    package_installation $PACKAGE_NAME
    PACKAGE_NAME="npm"
    package_installation $PACKAGE_NAME

}

angular_install() {
	#TODO if node_js is installed than:
	sudo npm install -g @angular/cli
	# if node_js is not installet than:
	node_js_install
	sudo npm install -g @angular/cli

}

