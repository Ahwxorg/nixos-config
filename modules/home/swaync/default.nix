{ pkgs, username, ... }:
{
  home = {
    packages = with pkgs; [ swaynotificationcenter ];
    file."/home/${username}/.config/swaync/config.json".text = ''
      {
        "positionX": "right",
        "positionY": "top",
        "layer": "overlay",
        "layer-shell": "true",
        "cssPriority": "application",
        "control-center-margin-top": 10,
        "control-center-margin-bottom": 10,
        "control-center-margin-right": 10,
        "control-center-margin-left": 10,
        "notification-icon-size": 64,
        "notification-body-image-height": 128,
        "notification-body-image-width": 200,
        "timeout": 10,
        "timeout-low": 5,
        "timeout-critical": 0,
        "fit-to-screen": true,
        "control-center-width": 400,
        "control-center-height": 650,
        "notification-window-width": 350,
        "keyboard-shortcuts": true,
        "image-visibility": "when-available",
        "transition-time": 200,
        "hide-on-clear": false,
        "hide-on-action": true,
        "script-fail-notify": true,
        "widgets": [
          "title",
          "dnd",
          "notifications"
        ],
        "widget-config": {
          "title": {
            "text": "Notifications",
            "clear-all-button": true,
            "button-text": " Clear all "
          },
          "dnd": {
            "text": " Do Not Disturb"
          },
        }
      }
    '';
    file = {
      "/home/${username}/.config/swaync/style.css".text = ''
        * {
          all: unset;
          font-size: 14px;
          font-family: "Ubuntu Nerd Font";
          transition: 200ms;
        }
        
        trough highlight {
          background: #cdd6f4;
        }
        
        scale trough {
          margin: 0rem 1rem;
          background-color: #313244;
          min-height: 8px;
          min-width: 70px;
        }
        
        slider {
          background-color: #89b4fa;
        }
        
        .floating-notifications.background .notification-row .notification-background {
          box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #313244;
          margin: 18px;
          background-color: #000000;
          color: #cdd6f4;
          padding: 0;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification {
          padding: 7px;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification.critical {
          box-shadow: inset 0 0 7px 0 #f38ba8;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification .notification-content {
          margin: 7px;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
          color: #cdd6f4;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
          color: #a6adc8;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
          color: #cdd6f4;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
          min-height: 3.4em;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
          color: #cdd6f4;
          background-color: #000000;
          box-shadow: inset 0 0 0 1px #45475a;
          margin: 7px;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #000000;
          color: #cdd6f4;
        }
        
        .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #000000;
          color: #cdd6f4;
        }
        
        .floating-notifications.background .notification-row .notification-background .close-button {
          margin: 7px;
          padding: 2px;
          color: #1e1e2e;
          background-color: #000000;
        }
        
        .floating-notifications.background .notification-row .notification-background .close-button:hover {
          background-color: #000000;
          color: #1e1e2e;
        }
        
        .floating-notifications.background .notification-row .notification-background .close-button:active {
          background-color: #000000;
          color: #1e1e2e;
        }
        
        .control-center {
          box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #313244;
          margin: 18px;
          background-color: #000000;
          color: #cdd6f4;
          padding: 14px;
        }
        
        .control-center .widget-title > label {
          color: #cdd6f4;
          font-size: 1.3em;
        }
        
        .control-center .widget-title button {
          color: #cdd6f4;
          background-color: #313244;
          box-shadow: inset 0 0 0 1px #45475a;
          padding: 8px;
        }
        
        .control-center .widget-title button:hover {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #585b70;
          color: #cdd6f4;
        }
        
        .control-center .widget-title button:active {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #74c7ec;
          color: #1e1e2e;
        }
        
        .control-center .notification-row .notification-background {
          color: #cdd6f4;
          background-color: #313244;
          box-shadow: inset 0 0 0 1px #45475a;
          margin-top: 14px;
        }
        
        .control-center .notification-row .notification-background .notification {
          padding: 7px;
        }
        
        .control-center .notification-row .notification-background .notification.critical {
          box-shadow: inset 0 0 7px 0 #f38ba8;
        }
        
        .control-center .notification-row .notification-background .notification .notification-content {
          margin: 7px;
        }
        
        .control-center .notification-row .notification-background .notification .notification-content .summary {
          color: #cdd6f4;
        }
        
        .control-center .notification-row .notification-background .notification .notification-content .time {
          color: #a6adc8;
        }
        
        .control-center .notification-row .notification-background .notification .notification-content .body {
          color: #cdd6f4;
        }
        
        .control-center .notification-row .notification-background .notification > *:last-child > * {
          min-height: 3.4em;
        }
        
        .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
          color: #cdd6f4;
          background-color: #11111b;
          box-shadow: inset 0 0 0 1px #45475a;
          margin: 7px;
        }
        
        .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #313244;
          color: #cdd6f4;
        }
        
        .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #74c7ec;
          color: #cdd6f4;
        }
        
        .control-center .notification-row .notification-background .close-button {
          margin: 7px;
          padding: 2px;
          color: #1e1e2e;
          background-color: #eba0ac;
        }
        
        .close-button {
        }
        
        .control-center .notification-row .notification-background .close-button:hover {
          background-color: #f38ba8;
          color: #1e1e2e;
        }
        
        .control-center .notification-row .notification-background .close-button:active {
          background-color: #f38ba8;
          color: #1e1e2e;
        }
        
        .control-center .notification-row .notification-background:hover {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #7f849c;
          color: #cdd6f4;
        }
        
        .control-center .notification-row .notification-background:active {
          box-shadow: inset 0 0 0 1px #45475a;
          background-color: #74c7ec;
          color: #cdd6f4;
        }
        
        .notification.critical progress {
          background-color: #f38ba8;
        }
        
        .notification.low progress,
        .notification.normal progress {
          background-color: #89b4fa;
        }
        
        .control-center-dnd {
          margin-top: 5px;
          background: #313244;
          border: 1px solid #45475a;
          box-shadow: none;
        }
        
        .control-center-dnd:checked {
          background: #313244;
        }
        
        .control-center-dnd slider {
          background: #45475a;
        }
        
        .widget-dnd {
          margin: 0px;
          font-size: 1.1rem;
        }
        
        .widget-dnd > switch {
          font-size: initial;
          background: #313244;
          border: 1px solid #45475a;
          box-shadow: none;
        }
        
        .widget-dnd > switch:checked {
          background: #313244;
        }
        
        .widget-dnd > switch slider {
          background: #45475a;
          border: 1px solid #6c7086;
        }
        
        .widget-mpris .widget-mpris-player {
          background: #313244;
          padding: 7px;
        }
        
        .widget-mpris .widget-mpris-title {
          font-size: 1.2rem;
        }
        
        .widget-mpris .widget-mpris-subtitle {
          font-size: 0.8rem;
        }
        
        .widget-menubar > box > .menu-button-bar > button > label {
          font-size: 3rem;
          padding: 0.5rem 2rem;
        }
        
        .widget-menubar > box > .menu-button-bar > :last-child {
          color: #f38ba8;
        }
        
        .power-buttons button:hover,
        .powermode-buttons button:hover,
        .screenshot-buttons button:hover {
          background: #313244;
        }
        
        .control-center .widget-label > label {
          color: #cdd6f4;
          font-size: 2rem;
        }
        
        .widget-buttons-grid {
          padding-top: 1rem;
        }
        
        .widget-buttons-grid > flowbox > flowboxchild > button label {
          font-size: 2.5rem;
        }
        
        .widget-volume {
          padding-top: 1rem;
        }
        
        .widget-volume label {
          font-size: 1.5rem;
          color: #74c7ec;
        }
        
        .widget-volume trough highlight {
          background: #74c7ec;
        }
        
        .widget-backlight trough highlight {
          background: #f9e2af;
        }
        
        .widget-backlight scale {
          margin-right: 1rem;
        }
        
        .widget-backlight label {
          font-size: 1.5rem;
          color: #f9e2af;
        }
        
        .widget-backlight .KB {
          padding-bottom: 1rem;
        }
      '';
    };
  };
}
