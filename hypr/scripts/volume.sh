#!/bin/bash

# iDIR="$HOME/.config/HyprV/mako/icons"

# Get Volume Level
get_volume() {
	volume=$(pamixer --get-volume)
	echo "$volume"
}

# Get volume icons
get_volume_icon() {
	current=$(get_volume)
	if [[ "$current" -eq "0" ]]; then
		echo ""
	elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
		echo ""
	elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
		echo ""
	elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
		echo ""
	fi
}

# Notify Volume Level
notify_volume() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 1000 "$(get_volume_icon)  Volume: $(get_volume)%"
}

# Notify Mute Status
notify_mute_volume() {
	local is_muted=$1
	if [[ "$is_muted" == true ]]; then
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 2000 "$(get_volume_icon)  Volume Switched On"
	else
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 2000 "Volume Switched Off"
	fi
}

# Increase Volume
inc_volume() {
	pamixer -i 5
	# && notify_volume
}

# Decrease Volume
dec_volume() {
	pamixer -d 5
	# && notify_volume
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify_mute_volume true
	elif [ "$(pamixer --get-mute)" == "false" ]; then
		pamixer -m && notify_mute_volume false
	fi
}

# Notify Mic Status
notify_mic_user() {
	local is_muted=$1
	if [[ "$is_muted" == true ]]; then
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "  Microphone Switched ON"
	else
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "󰍭  Microphone Switched OFF"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m && notify_mic_user false
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u && notify_mic_user true
	fi
}

# Get icons
# get_mic_icon() {
# 	current=$(pamixer --default-source --get-volume)
# 	if [[ "$current" -eq "0" ]]; then
# 		echo "$iDIR/microphone.png"
# 	elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
# 		echo "$iDIR/microphone.png"
# 	elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
# 		echo "$iDIR/microphone.png"
# 	elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
# 		echo "$iDIR/microphone.png"
# 	fi
# }

# Increase MIC Volume
inc_mic_volume() {
	pamixer --default-source -i 5
	# && notify_mic_user
}

# Decrease MIC Volume
dec_mic_volume() {
	pamixer --default-source -d 5
	# && notify_mic_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
	get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
