#!/usr/bin/env bash
# unfuck system when shit goes wrong

usage() {
	echo "usage: unfuck [OPTION]"
	echo "example: unfuck everything"
}

unfuck_wallpaper() {
	pkill swww-daemon
	setsid swww-daemon &
}

unfuck_bar() {
	pkill waybar
	setsid waybar &
}

unfuck_networkmanager() {
	sudo systemctl restart NetworkManager
}

unfuck_spotify() {
	if pgrep ncspot; then
		pkill ncspot
		ncspot
	elif pgrep spotify; then
		pkill spotify
		spotify
	fi
}

unfuck_screenlock() {
	hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
	hyprctl --instance 0 'dispatch exec lockscreen'
}

case $1 in
"")
	echo "what is fucked?"
	;;
-h | --help)
	usage
	;;
everything)
	unfuck_screenlock
	unfuck_bar
	unfuck_spotify
	unfuck_wallpaper
	;;
*)
	eval "unfuck_$1"
	;;
esac
