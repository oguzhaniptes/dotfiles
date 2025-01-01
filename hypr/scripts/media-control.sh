#!/bin/bash

next() {
	playerctl next
}

previous() {
	playerctl previous
}

stop() {
	playerctl --player=%any pause
}

play() {
	playerctl --player=%any play-pause
}

if [[ "$1" == "--next" ]]; then
	next
elif [[ "$1" == "--prev" ]]; then
	previous
elif [[ "$1" == "--stop" ]]; then
	stop
elif [[ "$1" == "--play" ]]; then
	play
fi
