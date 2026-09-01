{
  pkgs,
  username,
  host,
  ...
}:
{
  home = {
    packages = with pkgs; [
      swaynotificationcenter
      wlogout
    ];
    file."/home/${username}/.config/swaync/config.json".text = ''
            {
              "control-center-margin-bottom": 4,
              "control-center-margin-left": 4,
              "control-center-margin-right": 4,
              "control-center-margin-top": 4,
              "control-center-width": 300,
              "cssPriority": "user",
              "fit-to-screen": true,
              "hide-on-action": false,
              "hide-on-clear": false,
              "image-visibility": "when-available",
              "keyboard-shortcuts": true,
              "notification-body-image-height": 100,
              "notification-body-image-width": 200,
              "notification-icon-size": 48,
              "notification-visibility": {
                "example-name": {
                  "app-name": "Spotify",
                  "state": "visible",
                  "urgency": "Low"
                }
              },
              "notification-window-width": 350,
              "positionX": "right",
              "positionY": "top",
              "script-fail-notify": true,
              "timeout": 4,
              "timeout-critical": 9,
              "timeout-low": 2,
              "transition-time": 200,
              "group-by": "none",
              "widget-config": {
                "buttons-grid": {
                  "actions": [
                    {
                      "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'",
                      "label": "WLAN",
                      "position": "left",
                      "type": "toggle",
                      "update-command": "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true || echo false'"
                    },
                    {
                      "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE = true ]] && bluetoothctl power on || bluetoothctl power off'",
                      "label": "Bluetooth",
                      "position": "right",
                      "type": "toggle",
                      "update-command": "sh -c 'bluetoothctl show | grep -q \"Powered: yes\" && echo true || echo false'"
                    },
                    {
                      "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && tailscale up || tailscale down'",
                      "label": "Tailscale",
                      "position": "left",
                      "type": "toggle",
                      "update-command": "sh -c 'tailscale status | grep -q \"${host}\" && echo true || echo false'"
                    },
                    {
                      "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && ${pkgs.wlsunset}/bin/wlsunset -t 3500 -T 6500 -S 07:00 -s 19:00 -g 0.7 || pkill -f wlsunset'",
                      "label": "Night",
                      "position": "left",
                      "type": "toggle",
                      "update-command": "sh -c 'pgrep -x wlsunset > /dev/null && echo true || echo false'"
                    },
                    {
                      "active": false,
                      "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && swaync-client --dnd-on || swaync-client --dnd-off'",
                      "label": "Do not disturb",
                      "position": "right",
                      "type": "toggle",
                      "update-command": "sh -c '[[ $(swaync-client --get-dnd) == \"true\" ]] && echo true || echo false'"
                    },
                    {
                      "command": "sh -c 'swaync-client --close-all'",
                      "label": "Clear all",
                      "position": "right"
                    }
                  ]
                },
                "mpris": {
                  "image-radius": 12,
                  "image-size": 96
                },
                "backlight": {
                  "device": "apple-panel-bl",
                  "label": "󰃞 "
                },
                "volume": {
                  "label": " ",
                  "show-per-app": true
                }
              },
              "widgets": [
                "buttons-grid",
                "notifications",
                "mpris",
                "backlight",
                "volume"
              ]
            }
      			'';
    file."/home/${username}/.config/swaync/style.css".text = ''
      @define-color base00 #161616; 
      @define-color base01 #262626; 
      @define-color base02 #393939; 
      @define-color base03 #525252; 
      @define-color base04 #dde1e6; 
      @define-color base05 #f2f4f8; 
      @define-color base06 #ffffff; 
      @define-color base07 #08bdba;
      @define-color base08 #3ddbd9; 
      @define-color base09 #78a9ff; 
      @define-color base0A #ee5396; 
      @define-color base0B #33b1ff; 
      @define-color base0C #ff7eb6; 
      @define-color base0D #42be65; 
      @define-color base0E #be95ff; 
      @define-color base0F #82cfff;

      * {
        color: @base05;
        all: unset;
        font-size: 16px;
        font-family: "SpaceMono Nerd Font";
        transition: 200ms;
      }

      .notification-row {
        color: @base04;
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .floating-notifications.background .notification-row .notification-background {
        background: @base00;
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.6);
        border: 0px;
        border-radius: 3px;
        margin: 16px;
        padding: 0px;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification {
        padding: 3px;
        border-radius: 3px;
        border: 1px solid @base04;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification.critical {
        border: 2px solid @base08;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        .notification-content {
        margin: 3px;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        > *:last-child
        > * {
        min-height: 3.4em;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        > *:last-child
        > *
        .notification-action {
        all: unset;
        border-radius: 4px;
        background-color: @base00;
        font-size: 5px;
        margin: 40px;
        font-weight: 200;
        min-height: 12px;
        padding: 0px;
        border: 1px solid transparent;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        > *:last-child
        > *
        .notification-action:hover {
        background-color: @base00;
        border: 1px solid @base01;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        > *:last-child
        > *
        .notification-action:active {
        background-color: @base01;
        color: @base04;
      }

      .image {
        margin: 10px 20px 10px 0px;
      }

      .summary {
        font-weight: 800;
        font-size: 1rem;
        color: @base06;
      }

      .body {
        font-size: 0.8rem;
        color: @base04;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .close-button {
        margin: 6px;
        padding: 2px;
        border-radius: 3px;
        background-color: transparent;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .close-button:hover {
        background-color: @base00;
        color: @base04;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .close-button:active {
        background-color: @base00;
        color: @base05;
      }

      .notification.critical progress {
        background-color: @base00;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @base00;
      }

      * {
        color: @base05;
        all: unset;
        font-size: 16px;
        font-family: "SpaceMono Nerd Font";
        font-weight: normal;
        transition: 200ms;
      }

      .control-center {
        background: @base00;
        border-radius: 3px;
        padding: 9px;
        margin: 0px;
        border: 1px solid #585b70;
      }

      /* buttons grid */

      .widget-buttons-grid {
        margin: 0px;
        background: transparent;
        color: @base05;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button {
        margin: 3px;
        padding: 6px 12px;
        background: @base00;
        color: @base05;
        border-radius: 3px;
        border: 1px solid #45475a;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button:hover {
        background: @base02;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
        background: @base0C;
        border: 1px solid #313244;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked label {
        color: @base01;
      }

      /* notifications */

      .notification-row .notification-background {
        background: @base00;
        padding: 0px;
        border-radius: 2px;
        margin: 5px 5px 5px 5px;
        border: 1px solid #313244;
      }

      .summary {
        font-size: 15px;
        background: transparent;
        color: @base05;
        margin-left: 0px;
      }

      .time {
        font-size: 11px;
        font-style: italic;
        background: transparent;
        color: @base04;
        text-shadow: none;
        margin: 3px 10px 0px 0px;
      }

      .image {
        background: transparent;
        border-radius: 99px;
        margin: 0px 10px 3px 2px;
      }

      .body {
        font-size: 13px;
        font-weight: normal;
        background: transparent;
        color: @base05;
        text-shadow: none;
        margin-left: 0px;
      }

      .notification-group-headers {
        font-weight: bold;
        font-size: 11pt;
        color: @base0E;
      }

      .notification-group-icon {
        color: @base0B;
        margin-right: 8px;
      }

      .notification-group-collapse-button {
        background: @base0A;
        color: @base00;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .notification-group-collapse-button:hover {
        background: @base08;
        color: @base01;
      }

      .notification-group-close-all-button {
        background: @base0A;
        color: @base00;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .notification-group-close-all-button:hover {
        background: @base08;
        color: @base01;
      }

      .notification-default-action,
      .notification-action {
        padding: 4px;
        margin: 0;
        box-shadow: none;
        background: transparent;
        border: none;
        color: @base05;
        transition: all 0.15s ease-in-out;
        font-size: 11pt;
      }

      .notification-default-action:hover,
      .notification-action:hover {
        background: @base00;
      }

      .notification-default-action {
        border-radius: 8px;
      }

      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0;
        border-bottom-right-radius: 0;
      }

      .notification-action {
        border-radius: 0;
        border-top: none;
        border-right: none;
      }

      .notification-action:first-child {
        border-bottom-left-radius: 10px;
        background: @base00;
      }

      .notification-action:last-child {
        border-bottom-right-radius: 10px;
        background: @base00;
      }

      .inline-reply {
        margin-top: 4px;
      }

      .inline-reply-entry {
        background: @base01;
        color: @base05;
        caret-color: @base0E;
        border: 1px solid @base02;
        border-radius: 10px;
      }

      .inline-reply-button {
        margin-left: 4px;
        background: @base01;
        border: 1px solid @base02;
        border-radius: 10px;
        color: @base05;
      }

      .inline-reply-button:disabled {
        background: initial;
        color: @base03;
        border: 1px solid transparent;
      }

      .inline-reply-button:hover {
        background: @base03;
      }

      /* Music player */
      .widget-mpris {
        /* background: alpha(@selected, 0.2); */
        border-radius: 3px;
        color: @base05;
        padding: 6px;
        margin: 20px 6px;
      }

      .widget-mpris button {
        color: alpha(@base0F, 0.9);
        border-radius: 4px;
      }

      .widget-mpris button:hover {
        color: @base05;
      }

      .widget-mpris-player {
        padding: 2px;
        margin: 2px 4px 4px 2px;
        border-radius: 3px;
      }

      .widget-mpris-album-art {
        border-radius: 3px;
      }

      .widget-mpris-title {
        font-weight: 700;
        font-size: 15px;
      }

      .widget-mpris-subtitle {
        font-weight: 500;
        font-size: 13px;
      }

      progressbar,
      progress,
      trough {
        border-radius: 3px;
        min-height: 20px;
        background: @base04;
      }

      trough highlight {
        padding: 4px;
        background: @base0C;
        border-radius: 3px;
      }
      trough slider {
        background: transparent;
      }
      trough slider:hover {
        background: transparent;
      }

      .widget-volume {
        background: @base00;
        padding: 2px 4px 2px 4px;
        margin: 4px 4px 1px 4px;
        border-radius: 2px;
        color: @base04;
        border: 1px solid #45475a;
      }

      .widget-volume > box > button {
        background: transparent;
        border: none;
      }

      .widget-backlight {
        background: @base00;
        color: @base04;
        padding: 2px 4px 2px 4px;
        margin: 1px 4px 4px 4px;
        border-radius: 2px;
        border: 1px solid #45475a;
      }
      .widget-backlight > box > button {
        background: transparent;
        border: none;
      }
    '';
  };
}
