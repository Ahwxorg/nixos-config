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
  };
  home.packages = with pkgs; [
    wf-recorder
    bemenu
  ];
}

