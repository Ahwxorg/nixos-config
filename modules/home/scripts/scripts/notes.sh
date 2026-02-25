#!/bin/sh

# MIT license
# liv < liv at liv dot town > https://liv.town - 2024
#
# Dependencies: find/grep/bemenu/ping/git/

NOTEDIR="$HOME/Notes"

if [ $(command -v bemenu) ]; then
	MENUCMD="bemenu -l 10 --ignorecase"
elif [ $(command -v fzf) ]; then
	MENUCMD="fzf"
else
	exit 1
fi

if [ $(command -v notify-send) ]; then
	NOTICMD="notify-send \"Pulling from Git...\""
elif [ $(command -v fzf) ]; then
	NOTICMD="osascript -e \'display notification \"Pulling from Git...\"\'"
else
	exit 1
fi

CHOSEN=$(find "$HOME/Notes" -follow | grep -E '.md$' | $MENUCMD)

cd "$NOTEDIR" || mkdir -p "$NOTEDIR" && cd "$NOTEDIR" || echo 'Error with moving into directory, is "$NOTEDIR" set?' # Change dir to notes dir, if it doesn't exist, create it and try again. Otherwise it should just die, I guess?
echo "Check if connected to internet and pull changes from Git"
ping -c1 github.com >/dev/null && $NOTICMD # Pull most recent changes, be sure to not create conficts...

if [ "$CHOSEN" ]; then
	kitty -e nvim "$CHOSEN" # Finally open chosen note
	git add "$CHOSEN" && git commit -m "chore: updates (auto)" && git push && notify-send "Changes pushed"
else
	exit 1
fi
