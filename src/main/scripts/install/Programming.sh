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

	# TODO: if node_js is installed than:
	sudo npm install -g @angular/cli
	# if node_js is not installet than:
	node_js_install
	sudo npm install -g @angular/cli

}

# JAVA

# TODO: JDK and stuff

# JETBRAINS TOOLBOX

jetbrains_toolbox_install() {

    PACKAGE_NAME="jetbrains-toolbox"
    PACKAGE_NAME_ARCHIVE="jetbrains-toolbox.tar.gz"
    TO_RUN_FILE_NAME="jetbrains-toolbox"
    URL="https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.8.3678.tar.gz"
    package_installation_from_url $PACKAGE_NAME
    
    # if [ "$TO_INSTALL_FLAG" = true ] ; then
    #     MESSAGE="Installing $PACKAGE_NAME"
    #     echo -e "\e[0;92m$MESSAGE\e[0m"
    #     log_entry
    #     #TODO: 
    #     #wget http://path/to/package/store(maybe dropbox) (zapisz w ~/Downloads)
    #     sudo cp -v ~/Downloads/jetbrains-toolbox-*.tar.gz /opt
    #     sudo tar -xzf /opt/jetbrains-toolbox-*.tar.gz
    #     sudo rm -v /opt/jetbrains-toolbox-*.tar.gz
    #     package_existence_control #TODO zrób lokalną metodę, to nie jest instalowane przez manager pakietów
    #     nemo /opt/jetbrains-toolbox* #odpalenie nemo, żeby sobie odpalić ten dziwny plik ręcznie
    #     #TODO: instrukcja o uruchomieniu toolboxa i instalacji ręcznej idea i innych, pausa dapóki klient nie ogarnie 
    #     #sobie tematu przez toolboxa
    # fi
}

# PYTHON

python-pip_install(){

    PACKAGE_NAME="python-pip"
    package_installation $PACKAGE_NAME
    pip install --upgrade pip
}

# POSTMAN

postman_install() {

    PACKAGE_NAME="Postman"
    PACKAGE_NAME_ARCHIVE=""
    URL="https://app.getpostman.com/app/download/linux64?_ga=2.25509050.687991264.1527005934-1283553646.1524695282"
    package_installation_from_url $PACKAGE_NAME

}

# SHELLCHECK

shellcheck_install() {

    PACKAGE_NAME="shellcheck"
    PACKAGE_DESCRIPTION="ShellCheck is a tool that gives warnings and suggestions for bash/sh shell scripts"
    package_installation $PACKAGE_NAME

}

# SQLITE BROWSER

sqlitebrowser_install() {

    # https://sqlitebrowser.org/
    PPA_NAME="ppa:linuxgndu/sqlitebrowser"
    PPA_URL="http://ppa.launchpad.net/linuxgndu/sqlitebrowser/ubuntu"
    PACKAGE_NAME="sqlitebrowser"
    PACKAGE_DESCRIPTION="GUI tool for managing SQLite databases"
    package_installation_from_ppa $PACKAGE_NAME $PPA_NAME $PPA_URL

}



