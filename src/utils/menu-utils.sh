#!/bin/bash

# arguments:
# first argument - variable containing map of data in pattern:
#   "keyName"="full name|Program description|./path/to/script"
# second argument - variable containing string with header of menu, like:
#   "File Managers"
# third argument - sub header
#   "Program for file browsing"
serve_multiple_choice_menu(){
    eval "declare -A options="${1#*=}
    local header=$2
    local sub_header=$3

    # this variable determinates number of spaces from the last character of longest position name in menu to 
    # the beginning of description 
    local space=1

    # this array contains keys of map
    local keys=(${!options[@]})
    # this array will contain all values from map
    local values=()
    # setting delimiter type
    IFS='|'
    # this loop takes each value from options, assigns to tmp array split by delimiter, takes first value from tmp array 
    # and assigns to values array declared above
    for value in "${options[@]}"; do
        read -ra tmp_array <<< "$value"
        extracted_value="${tmp_array[0]}"
        values+=($extracted_value) ;
    done

    #find longest program name in order to determinate align right value
    local longest_name=-1
    for x in ${values[@]}; do
       if [ ${#x} -gt $longest_name ]; then
          longest_name=${#x}
       fi
    done

    # MENU LOGIC
    menu(){
        clear
        echo -e "$header"
        echo -e "$sub_header\n"
        echo -e "Choose programs to install:\n"
        for i in ${!keys[*]}; do
            # align
            read -ra array_of_map_values <<< "${options[${keys[i]}]}"
            local program_name_length=${#array_of_map_values[0]}
            local align_right_factor=$(( $longest_name - $program_name_length + $space ))
            # display menu
            printf "%3d%s) %s %"$align_right_factor"s %s\n" $((i+1)) "${choices[i]:- }" "${array_of_map_values[0]}" "-" "${array_of_map_values[1]}"
        done
        [[ "$msg" ]] && echo "" && echo "$msg" && msg=""; :
    }

    prompt="Check program to install (type index again to uncheck, ENTER when done): "
    while menu && echo "" && read -rp "$prompt" num && [[ "$num" ]]; do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#options[@]} )) ||
        { msg="Invalid option: $num"; continue; }
        ((num--)); #msg="${options[num]} was ${choices[num]:+un}checked"
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="*"
    done

    # code below should be transformed into action of installing or sourcing for later installation
    echo -e "\nSelected programs:"
    for i in ${!choices[@]}; do
        if [ ${choices[i]} == * ]; then
            read -ra array_of_map_values <<< "${options[${keys[i]}]}"
            echo "${array_of_map_values[1]}"
        fi
    done

    IFS=' '
}

serve_multi_level_menu(){
    eval "declare -A options="${1#*=}
    local header=$2
    local sub_header=$3

    # this variable determinates number of spaces from the last character of longest position name in menu to 
    # the beginning of description 
    local space=1

    # this array contains keys of map
    local keys=(${!options[@]})
    # this array will contain all values from map
    local values=()
    # setting delimiter type
    IFS='|'
    # this loop takes each value from options, assigns to tmp array split by delimiter, takes first value from tmp array 
    # and assigns to values array declared above
    for value in "${options[@]}"; do
        read -ra tmp_array <<< "$value"
        extracted_value="${tmp_array[0]}"
        values+=($extracted_value) ;
    done

    #find longest program name in order to determinate align right value
    local longest_name=-1
    for x in ${values[@]}; do
       if [ ${#x} -gt $longest_name ]; then
          longest_name=${#x}
       fi
    done

    # MENU LOGIC
    menu(){
        clear
        echo -e "$header"
        echo -e "$sub_header\n"
        # echo -e "Choose programs to install:\n"
        for i in ${!keys[*]}; do
            # align
            read -ra array_of_map_values <<< "${options[${keys[i]}]}"
            local program_name_length=${#array_of_map_values[0]}
            local align_right_factor=$(( $longest_name - $program_name_length + $space ))
            # display menu
            printf "%3d) %s %"$align_right_factor"s %s\n" $((i+1)) "${array_of_map_values[0]}" "-" "${array_of_map_values[1]}"
        done
        [[ "$msg" ]] && echo "" && echo "$msg" && msg=""; :
    }

    prompt="Go to submenu (type index again to uncheck, ENTER when done): "
    while menu && echo "" && read -rp "$prompt" num && [[ "$num" ]]; do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#options[@]} )) ||
        { msg="Invalid option: $num"; continue; }
        # ((num--)); #msg="${options[num]} was ${choices[num]:+un}checked"
        # [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="*"
        read -ra array_of_map_values <<< "${options[${keys[$num]}]}"
        # echo "go to" "${array_of_map_values[2]}"
        bash "${array_of_map_values[2]}" &
    done

    # code below should be transformed into action of installing or sourcing for later installation
    # echo -e "\nSelected programs:"
    # for i in ${!choices[@]}; do
    #     if [ ${choices[i]} == * ]; then
    #         read -ra array_of_map_values <<< "${options[${keys[i]}]}"
    #         echo "${array_of_map_values[1]}"
    #     fi
    # done

    IFS=' '
}