{ pkgs, username, ... }:

{
  home.file = {
    "/home/${username}/.local/bin/waybar-yubikey" = {
      executable = true;
      text = ''
        socket="''${XDG_RUNTIME_DIR:-/run/user/$UID}/yubikey-touch-detector.socket"

        while true; do
            touch_reasons=()

            if [ ! -e "$socket" ]; then
                printf '{"text": "Waiting for YubiKey socket"}\n'
                while [ ! -e "$socket" ]; do sleep 1; done
            fi
            printf '{"text": ""}\n'

            nc -U "$socket" | while read -n5 cmd; do
                reason="''${cmd:0:3}"

                if [ "''${cmd:4:1}" = "1" ]; then
                    touch_reasons+=("$reason")
                else
                    for i in "''${!touch_reasons[@]}"; do
                        if [ "''${touch_reasons[i]}" = "$reason" ]; then
                            unset 'touch_reasons[i]'
                            break
                        fi
                    done
                fi

                if [ "''${#touch_reasons[@]}" -eq 0 ]; then
                    printf '{"text": ""}\n'
                else
                    if [ "$1" == "0" ]; then
                      printf '{"text": ""}\n'
                    else
                      printf '{"text":"%s"}\n' "''${touch_reasons[@]}"
                    fi
                fi
            done

            sleep 1
        done
      '';
    };
    "/home/${username}/.local/bin/waybar-screenrecord" = {
      executable = true;
      text = ''
        #!/bin/sh

        output_off="{\"text\": \"<span color='#aaaaaa'></span>\", \"tooltip\": \"Not recording\", \"alt\": \"\", \"class\": \"\" }"
        output_rec="{\"text\": \"<span color='#e98989'></span>\", \"tooltip\": \"Recording\", \"alt\": \"\", \"class\": \"\" }"

        pidof wf-recorder > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
          if [[ "$1" == "toggle" ]]
          then
            killall -s SIGINT wf-recorder > /dev/null 2>&1
            notify-send -a screenrecorder -t 3000 'Screen recording' "Screen recording was stopped!"
            echo -n $output_off
            exit 0
          fi
          echo -n $output_rec
          exit 0
        else
          if [[ "$1" == "toggle" ]]
          then
            geometry=$(slurp)
            if [ $? -eq 0 ]
            then
              notify-send -a screenrecorder -t 3000 'Screen recording' "Screen recording was started!"
              sleep 3
              wf-recorder -f "$HOME/downloads/$(date +'screenrecording_%Y-%m-%d-%H%M%S.mp4')" -g "$geometry" > /dev/null 2>&1 &
              echo -n $output_rec
              exit 0
            fi
          fi
          echo -n $output_off
          exit 0
        fi
      '';
    };
    "/home/${username}/.local/bin/waybar-bluetooth" = {
      executable = true;
      text = ''
        #!/usr/bin/env zsh

        typeset -A known=(
          'headphones' '38:18:4C:D1:AE:48'
          'airpods' '2C:18:09:EF:BD:11'
        )

        function get_addr_or_fail () {
          if [ "$known[$1]" = "" ]
          then
            printf 'No device specified\n'
            exit 1 
          fi
          printf "$known[$1]"
        }

        case "$1" in
          "list")
            for k v ("''${(@kv)known}") printf "$k\n"
            ;;
          "toggle")
            device=""
            tmp="$2"
            if [ "$tmp" = "" ] 
            then
              tmp=$($0 list | bemenu --ignorecase)
            fi
            device=$(get_addr_or_fail "$tmp")
            is_connected=$(bluetoothctl info $device | grep -i 'connected: yes')
            if [ "$is_connected" != "" ]
            then
              bluetoothctl disconnect $device
            else
              bluetoothctl connect $device
            fi
            ;;
          "status")
            device=$(get_addr_or_fail "$2")
            is_connected=$(bluetoothctl info $device | grep -i 'connected: yes')
            if [ "$is_connected" != "" ]
            then
              echo "{\"text\": \"Connected\", \"class\": \"custom-btdevice\", \"alt\": \"connected\" }"
            else 
              echo "{\"text\": \"Disconnected\", \"class\": \"custom-btdevice\", \"alt\": \"disconnected\" }"
            fi
            ;;
          *)
            printf "$0 list|toggle <device>|status <device>\n"
            exit 1
            ;;
        esac
      '';
      # "/home/${username}/.local/bin/waybar-cpu" = {
      #   executable = true;
      #   text = ''
      #   '';
      # };
    };
    "/home/${username}/.local/bin/waybar-minutes" = {
      executable = true;
      text = ''
        #!/bin/sh

        echo $(( (24 - $(date +%H)) * 60 - $(date +%M) ))
      '';
    };
    "/home/${username}/.local/bin/waybar-music" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        META="{{ trunc(artist,17) }} - {{ trunc(title,17) }}"
        PLAYERS="spotify ncspot mpv mpd"

        for PLAYER in $PLAYERS; do
        	# if the player is not playing, continue to the next player, until we find one that is playing
        	[ "$(playerctl --player=$PLAYER status 2>/dev/null)" != "Playing" ] && continue
        	text=$(playerctl metadata --player $PLAYER --format "$META")
        	echo -e "{\"text\":\""$text"\", \"class\":\"Playing\"}"
        	exit 0
        done

        ICON="❚❚ "
        PAUSERS="spotify ncspot mpd"
        for PAUSER in $PAUSERS; do
        	[ "$(playerctl --player=$PAUSER status 2>/dev/null)" == "Paused" ] || [ "$(playerctl --player=$PAUSER status 2>/dev/null)" == "Stopped" ] && text="$ICON"$(playerctl metadata --player $PAUSER --format "$META") && echo -e "{\"text\":\""$text"\", \"class\":\""paused"\"}" && exit 0
        done
      '';
    };
    "/home/${username}/.local/bin/waybar-devices" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        if [[ "$(hostname)" == "sakura" ]]; then
          MICROPHONE_STATE="$(sudo framework_tool --privacy | tail -n2 | head -n1)"
          CAMERA_STATE="$(sudo framework_tool --privacy | tail -n1)"

          if [[ "$(echo $MICROPHONE_STATE | grep 'Microphone: Connected')" ]]; then
          	MIC=1
          	MTEXT="󰍬 - available!"
          else
          	MIC=0
          	MTEXT=" "
          fi

          if [[ "$(echo $CAMERA_STATE | grep 'Camera: Connected')" ]]; then
          	CAM=1
          	CTEXT="󰄀 - available!"
          else
          	CAM=0
          	CTEXT="󰗟 "
          fi

          echo "$CTEXT $MTEXT"
        fi
      '';
    };
    "/home/${username}/.local/bin/waybar-powerdraw" = {
      executable = true;
      text = ''
        #!/usr/bin/env zsh

        if [[ -f /sys/class/power_supply/BAT1/status && "$(cat /sys/class/power_supply/BAT1/status)" == "Discharging" ]]; then; cat /sys/class/power_supply/BAT1/current_now /sys/class/power_supply/BAT1/voltage_now | xargs | awk '{print $1*$2/1e12 " W"}'; fi
      '';
    };
    "/home/${username}/.local/bin/waybar-vpn" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        ip route | grep -q '10.7.0.0' \
        && echo '{"text":"Connected","class":"connected","percentage":100}' \
        || echo '{"text":"Disconnected","class":"disconnected","percentage":0}'
      '';
    };
  };
  home.packages = with pkgs; [
    wf-recorder
    bemenu
    ncspot
  ];
}
