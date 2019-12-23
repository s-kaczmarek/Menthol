#!/bin/bash

bash ./src/utils/tmp-utils.sh
# source ./src/utils/menu-utils.sh
source ./src/utils/multi-level-menu-utils.sh

declare -A options=(
        ["FileManagers"]="File Managers|Programs for browsing files|./src/agregats/file-managers.sh"
        ["Gaming"]="Gaming|All you need for playing games|./src/agregats/file-managers.sh"
        ["SystemTools"]="System Tools|Resources monitoring, file search, networking|./src/agregats/file-managers.sh"
    )

loop="true"
while [ $loop == "true" ]; do
    clear
    header="Menthol"
    sub_header="Options:"
    serve_multi_level_menu "$(declare -p options)" "$header" "$sub_header"
done