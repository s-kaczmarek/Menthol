#!/bin/bash

# This scripts job is to write informations about computer and operating system to system-info.tmp

SYSTEM_INFO_TMP_PATH="./tmp/system-info.tmp"

linux_distro_detection(){
    local version=$(cat /etc/*-release | grep "DISTRIB_ID" | awk -F"=" '{print $2}')
    local distro=""

    case "$version" in
        Ubuntu) distro="ubuntu" ;;
          Arch) distro="arch" ;;
             *) distro="unrecognised distro: $version"
    esac

    echo $distro
}

generate_system_info(){
    distro=$(linux_distro_detection)
    echo "DISTRIBUTION=$distro"   > $SYSTEM_INFO_TMP_PATH
}

generate_system_info