#!/usr/bin/env bash
TAB=$'\t'

if grep open /proc/acpi/button/lid/LID0/state; then
    if [[ $(hyprctl monitors | grep "model" | awk "NR==1") == "${TAB}model: DELL S2721DS" ]]; then
        hyprctl keyword monitor "eDP-1, 1920x1080@144, 0x0, 1"
        hyprctl keyword monitor "HDMI-A-1, 2560x1440@75, 1920x-720, 1"
    else
        hyprctl keyword monitor "eDP-1, 1920x1080@144, 0x0, 1"
        hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1"
    fi
else
    if [[ $(hyprctl monitors | grep "Monitor" | wc -l) != 1 ]]; then
        if [[ $(hyprctl monitors | grep "model" | awk "NR==1") == "${TAB}model: DELL S2721DS" ]]; then
            hyprctl keyword monitor "eDP-1, disable"
            hyprctl keyword monitor "HDMI-A-1, 2560x1440@75, 0x0, 1"
        else
            hyprctl keyword monitor "eDP-1, disable"
            hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1"
        fi
    fi
fi
