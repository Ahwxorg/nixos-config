#!/bin/bash

PERCENTAGE="$(pmset -g batt | grep -Eo "...%" | awk '{print $1}')"
CHARGING="$(pmset -g batt | grep 'AC Power')"

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status

if [[ "$CHARGING" != "" ]]; then
  STATE="CHAR:"
else
  STATE="BATT:"
fi

sketchybar --set "$NAME" label="$STATE $PERCENTAGE"
