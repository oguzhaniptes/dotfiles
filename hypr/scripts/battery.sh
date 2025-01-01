#!/bin/bash

upower=$(upower -i $(upower -e | grep BAT))

bat=$(grep percentage <<<$upower | awk "{print \$2}" | sed -e "s/%//")

if ! grep "discharging" <<<$upower >/dev/null; then
    charging_icon="󱐋"
else
    charging_icon=""
fi

if ((bat >= 90)); then
    battery_icon=""
elif ((bat >= 70)); then
    battery_icon=""
elif ((bat >= 35)); then
    battery_icon=""
elif ((bat >= 20)); then
    battery_icon=""
else
    battery_icon=""
fi

printf "%s %s %4s%%\n" "$charging_icon" "$battery_icon" "$bat"
