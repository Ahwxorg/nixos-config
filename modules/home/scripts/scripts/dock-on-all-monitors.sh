#!/usr/bin/env bash

set -e
set -x

last="$(hyprctl monitors | grep Monitor | sed 's/Monitor //g' | awk '{print $3}' | sed 's/)://g' | sed ':a;N;$!ba;s/\n/ /g' | awk '{print $NF}')"

hyprctl dispatch focusmonitor 0
setsid nwg-dock-hyprland -m -l top &

sleep 0.5

((last = last + 1)) # make number be one higher so it also takes last window (this is required as we used `i < "$last"`)
for ((i = 0; i < "$last"; i++)); do
	hyprctl dispatch focusmonitor "$i"
	setsid nwg-dock-hyprland -m -l top -c 'bemenu-run -l 5' &
	sleep 0.5
done
