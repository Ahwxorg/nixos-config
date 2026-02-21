#!/bin/sh

sketchybar --set "$NAME" label="$(nowplaying-cli get title) - $(nowplaying-cli get artist)"
