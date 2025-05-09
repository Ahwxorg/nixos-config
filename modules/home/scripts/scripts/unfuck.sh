#!/usr/bin/env bash
# unfuck system when shit goes wrong

unfuckable=(
	"wallpaper"
	"bar"
	"networkmanager"
	"spotify"
	"audio"
	"screenlock"
)

usage() {
	echo "INFO: usage; unfuck [OPTION]"
	echo "INFO: example; unfuck everything"
	echo ""
	echo "INFO: items: ${unfuckable[*]}"
	echo ""
	echo "WARN: unfuck everything should only be used when *everything* is broken and nothing works anymore!"
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
	# sudo modprobe -r iwlwifi
	# sudo modprobe iwlwifi
	sudo systemctl restart NetworkManager
}

unfuck_spotify() {
	if pgrep ncspot; then
		pkill ncspot
		kitty -e ncspot
	elif pgrep spotify; then
		pkill spotify
		spotify
	fi
}

unfuck_audio() {
	if [[ "$(playerctl status)" == "Playing" ]]; then
		playerctl pause
	fi
	for device in $(bluetoothctl devices Connected | awk '{print $2}'); do
		devices+=("$device")
	done
	systemctl --user restart wireplumber pipewire pipewire-pulse bluetooth
	bluetoothctl power off
	bluetoothctl power on
	for device in ${devices[*]}; do
		# because bluetooth is the worst thing ever created and defaults to handset mode, devices will need to reconnect
		echo "INFO: disconnecting and reconnecting to $device"
		bluetoothctl disconnect "$device"
		bluetoothctl connect "$device"
	done
}

unfuck_screenlock() {
	hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
	hyprctl --instance 0 'dispatch exec hyprlock'
}

case $1 in
"")
	echo "what is fucked?"
	;;
-h | --help | help)
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
