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
  swww img ~/.local/share/bg.png
}

unfuck_fingerprint() {
  notify-send "Touch sensor or use YubiKey." "Sleeping for 10 seconds."
  sleep 10
  sudo systemctl restart fprintd.service
}

unfuck_bar() {
  pkill waybar
  setsid waybar &
}

unfuck_dock() {
  pkill nwg-dock-hyprland
  setsid nwg-dock-hyprland -l top &
}

unfuck_networkmanager() {
  # sudo modprobe -r iwlwifi
  # sudo modprobe iwlwifi
  notify-send "Touch sensor or use YubiKey." "Sleeping for 10 seconds."
  sleep 10
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
  rfkill block bluetooth
  rfkill unblock bluetooth
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
  unfuck_fingerprint
  ;;
*)
  eval "unfuck_$1"
  ;;
esac
