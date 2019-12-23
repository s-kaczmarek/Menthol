#!/bin/bash

# declare map in order: "key" = "display_name path_to_script"
# index numbers will be assigned automatically
declare -A options=(
        ["Ranger"]="Ranger|Cli file manager|./src/common/ranger-install.sh"
        ["MidnightCommander"]="Midnight Commander|Two pane file manager|./src/common/midnight-commander-install.sh"
    )
# this array contains keys of map
keys=(${!options[@]})
# this array contains all values from map
values=()

# setting delimiter type
IFS='|'

# this loop takes each value from map, assings to tmp array split by ddelimiter, takes first value from tmp array and assigns to values array
for value in "${options[@]}"; do
    read -ra tmp_array <<< "$value"
    extracted_value="${tmp_array[0]}"
    values+=($extracted_value) ;
done

#find longest program name in order to determinate align right value
longest_name=-1
for x in ${values[@]}; do
   if [ ${#x} -gt $longest_name ]; then
      longest_name=${#x}
   fi
done
echo $longest_name

space=1

menu(){
    clear
    echo -e "Choose programs to install:\n"
    for i in ${!keys[*]}; do
        read -ra array_of_map_values <<< "${options[${keys[i]}]}"
        program_name_length=${#array_of_map_values[0]}
        # echo "length of ${array_of_map_values[0]} = $program_name_length"
        align_right_factor=$(( $longest_name - $program_name_length + $space ))
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
        # echo "${options[i]}"
        # echo "${keys[i]}"
        read -ra array_of_map_values <<< "${options[${keys[i]}]}"
        echo "${array_of_map_values[1]}"
    fi
done

IFS=' '