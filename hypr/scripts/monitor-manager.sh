#!/usr/bin/env bash
TAB=$'\t'
MY_INTERNAL_DISPLAY_MODEL="0x004D"
MY_MONITOR_MODEL="DELL S2721DS"

if [[ $(hyprctl monitors | grep "Monitors" | wc -l) == 1 ]]; then
  if [[ $(hyprctl monitors | grep "model" | awk "NR==1") == "${TAB}model: ${MY_INTERNAL_DISPLAY_MODEL}" ]]; then
    hyprctl keyword monitor "eDP-1, 1920x1080@144, 0x0, 1"
  elif [[ $(hyprctl monitors | grep "model" | awk "NR==1") == "${TAB}model: ${MY_MONITOR_MODEL}" ]]; then
    hyprctl keyword monitor "HDMI-A-1, 2560x1440@75, 0x0, 1"
  else
    hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1"
  fi
else
  if [[ $(hyprctl monitors | grep "${TAB}model: ${MY_MONITOR_MODEL}") ]]; then
    hyprctl keyword monitor "eDP-1, 1920x1080@144, -1920x0, 1"
    hyprctl keyword monitor "HDMI-A-1, 2560x1440@75, 0x0, 1"
  else
    hyprctl keyword monitor "eDP-1, 1920x1080@144, 0x0, 1"
    hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1"
  fi
fi
