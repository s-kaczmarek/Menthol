#!/bin/bash

# Chcek if .menthol already exists
# If no than:

install_all() {
    mv -v ../Menthol ~/.menthol
    cd ~/.menthol
    # Check if file exists in location and ask for overwrite v
    cp ~/.menthol/resources/desktop/Menthol.desktop ~/.local/share/applications
    # Check if file exists in location and ask for overwrite v
    cp ~/.menthol/resources/menthol.sh /usr/bin/menthol.sh
}

# if yeas than:
# ask what to do