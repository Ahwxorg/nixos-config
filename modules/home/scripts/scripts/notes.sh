#!/bin/sh

# MIT license
# Ahwx <ahwx at ahwx dot org> https://ahwx.org - 2024
#
# Dependencies: find/grep/tofi/ping/git/

NOTEDIR="$HOME/Notes"

CHOSEN=$(find "$HOME/Notes" -follow | grep -E '.md$' | tofi)

cd "$NOTEDIR" || mkdir -p "$NOTEDIR" && cd "$NOTEDIR" || echo 'Error with moving into directory, is "$NOTEDIR" set?' # Change dir to notes dir, if it doesn't exist, create it and try again. Otherwise it should just die, I guess?
notify-send "Trying to connect to internet and pull changes from Git"
ping -c1 github.com >/dev/null && notify-send "$(git pull)" # Pull most recent changes, be sure to not create conficts...

foot -e nix run "$HOME/Development/nixvim" -- "$CHOSEN" # Finally open chosen note

git add "$CHOSEN" && git commit -m "chore: updates (auto)" && git push && notify-send "Done"
