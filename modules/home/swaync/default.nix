{ pkgs, username, ... }:
{
  home = {
    packages = with pkgs; [
      swaynotificationcenter
      wlogout
    ];
    file."/home/${username}/.config/swaync/config.json".text = ''
            {
              "$schema": "/etc/xdg/swaync/configSchema.json",
              "positionX": "center",
              "positionY": "top",
              "layer": "overlay",
              "layer-shell": true,
              "cssPriority": "user",
            
              "control-center-width": 380,
              "control-center-height": 860,
              "control-center-margin-top": 8,
              "control-center-margin-bottom": 8,
              "control-center-margin-right": 8,
              "control-center-margin-left": 8,
            
              "notification-window-width": 400,
              "notification-icon-size": 48,
              "notification-body-image-height": 160,
              "notification-body-image-width": 200,
            
              "widgets": ["buttons-grid", "title", "dnd", "notifications", "mpris"],
              "widget-config": {
                "title": {
                  "text": "Notifications",
                  "clear-all-button": true,
                  "button-text": "Clear All"
                },
                "dnd": {
                  "text": "Do Not Disturb"
                },
                "label": {
                  "max-lines": 1,
                  "text": " "
                },
                "mpris": {
                  "image-size": 60,
                  "image-radius": 12
                },
                "buttons-grid": {
                  "actions": [
                    {
                      "label": " ",
                      "command": "kitty -e nmtui-connect"
                    },
                    {
                      "label": "󰂯",
                      "command": "waybar-bluetooth toggle"
                    },
                    {
                      "label": "󰏘",
                      "command": "kitty -e walp"
                    },
                    {
                      "label": "⏻",
                      "command": "wlogout"
                    }
                  ]
                }
              }
      }
    '';
    file."/home/${username}/.config/swaync/style.css".text = ''
      @import "../../.cache/wal/colors-waybar.css";

      @define-color text @foreground;
      @define-color bg @color1;
      @define-color selected @color6;
      @define-color hover alpha(@selected, .4);

      * {
        outline: none;
        transition: 200ms;
        padding: 1px;
        background: rgb(0, 0, 0, 0.75);
      }

      .notification-row {
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .notification-row .notification-background .close-button {
        /* The notification Close Button */
        background: rgb(0, 0, 0, 0.75);
        color: @text;
        text-shadow: none;
        box-shadow: none;
        margin-top: 2px;
        margin-right: 2px;
        padding: 0;
        border: none;
        border-radius: 100%;
        min-width: 24px;
        min-height: 24px;
      }

      .notification-row .notification-background .close-button:hover {
        box-shadow: none;
        background: rgb(0, 0, 0, 0.75);
        transition: background 0.15s ease-in-out;
        border: 0px;
      }

      .notification-row .notification-background .notification {
        /* The actual notification */
        background: rgb(0, 0, 0, 0.75);
      }

      .notification-group .notification-group-headers {
        /* Notficiation Group Headers */
        margin-top: 10px;
        margin-bottom: 10px;
      }

      .notification-group .notification-group-headers .notification-group-header {
        font-size: 20px;
        margin-left: 3px;
      }

      .notification-group.collapsed .notification-row .notification {
        background: alpha(@background, 0.55);
      }

      .control-center {
        /* The Control Center which contains the old notifications + widgets */
        margin: 18px;
        padding: 14px;
        box-shadow: 0px 2px 5px black;
        background: alpha(@background, 0.55);
        border: 2px solid @selected;
      }

      .control-center-clear-all {
        /* Clear All button */
        background: rgb(0, 0, 0, 0.75);
        padding: 5px;
      }

      .control-center-clear-all:hover {
        background: @hover;
      }

      .control-center-clear-all:active {
        background: @selected;
      }

      /*** Widgets ***/
      /* Title widget */
      .widget-title {
        background: rgb(0, 0, 0, 0.75);
        margin-top: 15px;
        margin-left: 15px;
        margin-right: 15px;
      }

      /* Do Not Disturb widget */
      .widget-dnd {
        background: rgb(0, 0, 0, 0.75);
        margin-left: 15px;
        margin-right: 15px;
      }

      .widget-dnd > switch {
        background: @bg;
        font-size: initial;
        border-radius: 12px;
        box-shadow: none;
        padding: 2px;
      }

      /* Media Player widget */
      @define-color mpris-album-art-overlay rgba(0, 0, 0, 0.55);
      @define-color mpris-button-hover rgba(0, 0, 0, 0.50);

      .widget-mpris {
      }

      .widget-mpris .widget-mpris-player {
        padding: 10px;
        margin: 8px 15px;
        /* background-color: @mpris-album-art-overlay; */
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.75);
        border: 2px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-size: 16px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        font-size: 14px;
      }

      /* Buttons widget */
      .widget-buttons-grid {
        /* background-color: alpha(@color2, 0.5); */
      }

      .widget-buttons-grid > flowbox > flowboxchild > button {
        /* background: alpha(@color2, 0.5); */
        /* border-radius: 12px; */
        min-width: 45px;
      }

      .control-center .notification-row .notification-background .notification {
        padding: 10px;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 10px;
        padding: 2px;
      }

      .floating-notifications.background .notification-row .notification-background {
        margin: 18px;
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 7px;
      }
    '';
  };
}
