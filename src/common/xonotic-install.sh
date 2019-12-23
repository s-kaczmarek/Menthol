#!/bin/bash

package_existence_control() {

    # This function is made to set value of PACKAGE_EXISTENCE to true or false depending on the existence of
    # package that we want to check. Use this variable as a flag to determinate weather install package or not.

    # pass name of the package as $1 argument
    # Example: package_existence_control $PACKAGE_NAME

    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 |grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        PACKAGE_EXISTENCE=false
    else
        PACKAGE_EXISTENCE=true
    fi
}

package_existence_control snap
if [ $PACKAGE_EXISTENCE  == false ]; then
    sudo apt install -y snapd
fi

snap install xonotic