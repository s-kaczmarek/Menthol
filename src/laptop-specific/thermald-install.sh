#!/bin/bash

source ../utils/Log.sh
source ../utils/ColorPalette.sh

# https://itsfoss.com/reduce-overheating-laptops-linux/
# https://wiki.debian.org/thermald
# http://www.webupd8.org/2014/04/prevent-your-laptop-from-overheating.html

# TODO - check if enabling intel_pstate makes sense
# TODO - check if there is point on using thermald with naother CPU than Intel

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

echo_message "======================="
echo_message "= Installing Thermald ="
echo_message "======================="
echo_message "Thermald prevents CPU overheating without a significant impact on performance by using some specific Intel functions available in the Linux Kernel."

# Check if this is desktop or laptop
CHASIS_TYPE=$(sudo dmidecode --string chassis-type)
if [ "Desktop" != "$CHASIS_TYPE" ]; then
    # Check if laptop has Intel CPU
    CPU_MANUFACTURER=$(sudo dmidecode -s processor-manufacturer)
    if [ "Intel(R) Corporation" == "$CPU_MANUFACTURER" ]; then
        package_existence_control thermald
        if [ $PACKAGE_EXISTENCE  == false ]; then
            echo_message "You are working on laptop with Intel CPU, we will install Thermald"
            sudo apt-get install thermald
        else
            echo_message "Thermald is already installed on your computer"
        fi
    else
        echo_message "You are working on laptop without Intel CPU. There is no need to install Thermald"
    fi
fi