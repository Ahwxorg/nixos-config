#!/bin/bash

boot=$(sysctl -n kern.boottime)
boot=${boot/\{ sec = /}
boot=${boot/,*/}
now=$(date +%s)
seconds=$((now - boot))
d="$((seconds / 60 / 60 / 24)) days"
h="$((seconds / 60 / 60 % 24)) hours"
m="$((seconds / 60 % 60)) minutes"

# Remove plural if < 2.
((${d/ */} == 1)) && d=${d/s/}
((${h/ */} == 1)) && h=${h/s/}
((${m/ */} == 1)) && m=${m/s/}

# Hide empty fields.
((${d/ */} == 0)) && unset d
((${h/ */} == 0)) && unset h
((${m/ */} == 0)) && unset m

uptime=${d:+$d, }${h:+$h, }$m
uptime=${uptime%', '}
uptime=${uptime:-$seconds seconds}

sketchybar --set "$NAME" label="up $uptime"
