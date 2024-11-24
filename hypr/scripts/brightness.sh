#!/usr/bin/env bash

# iDIR="$HOME/.config/HyprV/mako/icons"

# Get brightness
get_backlight() {
	LIGHT=$(printf "%.1f\n" $(brightnessctl i))
	echo "${LIGHT}%"
}

# My laptop screen
device_name="amdgpu_bl2"

get_backlight_percentage() {
	raw_percentage=$(brightnessctl -m -d "$device_name" | awk -F, '{print substr($4, 0, length($4)-1)}')
	percentage=$(((($raw_percentage + 2) / 5) * 5))
	echo "$percentage"
}

# Get icons
get_icon() {
	backlight="$(brightnessctl g)"
	if [[ ("$backlight" -ge "0") && ("$backlight" -le "85") ]]; then
		echo "󰃞"
	elif [[ ("$backlight" -ge "86") && ("$backlight" -le "170") ]]; then
		echo "󰃟"
	elif [[ ("$backlight" -ge "171") && ("$backlight" -le "255") ]]; then
		echo "󰃠"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 1000 "$(get_icon)  Brightness: $(get_backlight_percentage)%"
}

# Increase brightness
inc_backlight() {
	brightnessctl set +10% && notify_user
}

# Decrease brightness
dec_backlight() {
	brightnessctl set 10%- && notify_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	brightnessctl g
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
