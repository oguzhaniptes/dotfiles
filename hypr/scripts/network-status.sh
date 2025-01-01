#!/bin/sh

connection_type=$(nmcli -t -f TYPE,STATE connection show --active | grep -E '^(802-11-wireless|802-3-ethernet)' | cut -d':' -f1)

if [[ "$connection_type" == "802-11-wireless" ]]; then
    strength=$(nmcli -f IN-USE,SIGNAL device wifi | grep '*' | awk '{print $2}')

    if [[ -z "$strength" ]]; then
        network_icon="󰤮"
    elif [[ "$strength" -le 25 ]]; then
        network_icon="󰤟"
    elif [[ "$strength" -le 50 ]]; then
        network_icon="󰤢"
    elif [[ "$strength" -le 75 ]]; then
        network_icon="󰤥"
    else
        network_icon="󰤨"
    fi
elif [[ "$connection_type" == "802-3-ethernet" ]]; then
    network_icon="󰈀"
else
    network_icon="󰤭"
fi

printf "%s " "$network_icon"
