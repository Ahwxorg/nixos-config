{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [ (import ./scripts.nix) ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
  };
  home.file = {
    "/home/${username}/.config/waybar/config" = {
      text = ''
                                [{
                                  "layer": "top",
                                  "position": "top",

                                  "modules-left": [
                                    "privacy",
                                    "network",
                                    "custom/vpn",
                                    "custom/devices",
                                    "custom/spotify",
                                    "tray",
                                  ],

                                  "modules-center": [
                                    "hyprland/workspaces",
                                  ],

                                  "modules-right": [
                                    "custom/yubikey#icon",
                                    "custom/yubikey#data",
                                    "group/hardware",
                                    "group/resources",
                                    "bluetooth",
                                    // "wireplumber",
                                    "group/audio",
                                    "group/battery",
                                    "group/clock"
                                  ],

                                  "hyprland/window": {
                                    "format": "{}",
                                    "rewrite": {
                                      "(.*) - zsh": "> [$1]"
                                    },
                                    "separate-outputs": true
                                  },

                                  "sway/workspaces": {
                                    "all-outputs": true,
                                    "disable-scroll": true,
                                    "format": "{name}"
                                  },

                                  "hyprland/workspaces": {
                                    "all-outputs": true,
                                    "disable-scroll": true,
                                    "format": "{name}"
                                  },

                                  // "group/network": {
                                  //   "orientation": "horizontal",
                                  //   "modules": [ 
                                  //     "network",
                                  //     "custom/vpn",
                                  //   ],
                                  //   "drawer": {
                                  //     "transition-left-to-right": true,
                                  //     "transition-duration": 500
                                  //   }
                                  // },
                                  
                                  "network": {
                                    "format": "󰈀 {ifname}",
                                    "format-wifi": "  {ipaddr}/{cidr} <span color='#aaaaaa'>{signalStrength}%</span>",
                                    "format-ethernet": "󰈀 {ipaddr}/{cidr}",
                                    "format-disconnected": "󰈂",
                                    "tooltip-format": "{ifname} via {gwaddr}",
                                    "tooltip-format-wifi": "{essid} ({signalStrength}%)",
                                    "tooltip-format-ethernet": "{ifname}",
                                    "tooltip-format-disconnected": "Disconnected"
                                  },

                                  "custom/vpn": {
        			    "format": "{icon}",
        			    "tooltip-format": "{text}",
        			    "format-icons": [ "","" ],
                                    "return-type": "json",
                                    "exec": "~/.local/bin/waybar-vpn",
                                    "interval": 30
                                  },

                        	  "custom/spotify": {
                                    "interval": 5,
                                    "return-type": "json",
                                    "exec": "~/.local/bin/waybar-music",
                                    "on-click": "playerctl play-pause",
                                    "escape": true
                                  },

                        	  "custom/devices": {
                                    "interval": 60,
                                    // "return-type": "json",
                                    "exec": "~/.local/bin/waybar-devices",
                                  },

                                  "privacy": {
                                    "icon-spacing": 8,
                                    "icon-size": 14,
                                    "transition-duration": 250,
                                    "modules": [
                                      {
                                        "type": "screenshare",
                                        "tooltip": true,
                                        "tooltip-icon-size": 24
                                      },
                                      {
                                        "type": "audio-out",
                                        "tooltip": true,
                                        "tooltip-icon-size": 24
                                      },
                                      {
                                        "type": "audio-in",
                                        "tooltip": true,
                                        "tooltip-icon-size": 24
                                      }
                                    ]
                                  },

                                  "tray": {
                                    "icon-size": 12,
                                    "spacing": 0
                                  },

                                  "sway/mode": {
                                    "format": " {}",
                                    "tooltip": false
                                  },

                                  "custom/yubikey#icon": {
                                    "exec": "~/.local/bin/waybar-yubikey 0",
                                    "return-type": "json"
                                  },

                                  "custom/yubikey#data": {
                                    "exec": "~/.local/bin/waybar-yubikey 1",
                                    "return-type": "json"
                                  },

                                  "group/hardware": {
                                    "orientation": "horizontal",
                                    "modules": [ 
                                      "cpu", 
                                      "temperature#cpu",
                                      "temperature#gpu",
                                      "temperature#nvme",
                                      "temperature#wifi"
                                    ],
                                    "drawer": {
                                      "transition-left-to-right": false,
                                      "transition-duration": 500
                                    }
                                  },

                                  "cpu": {
                                    "interval": 30,
                                    "format": " {avg_frequency:3.2f}GHz <span color='#aaaaaa'>{usage}%</span>",
                                    "states": {
                                      "warning": 70,
                                      "critical": 90
                                    },
                                  },

                                  "temperature#cpu": {
                                    "hwmon-path": "/sys/class/hwmon/hwmon5/temp1_input",
                                    "critical-threshold": 80,
                                    "format": " CPU <span color='#aaaaaa'>{temperatureC}°C</span>"
                                  },

                                  "temperature#gpu": {
                                    "hwmon-path": "/sys/class/hwmon/hwmon0/temp1_input",
                                    "critical-threshold": 80,
                                    "format": "· GPU <span color='#aaaaaa'>{temperatureC}°C</span>"
                                  },

                                  "temperature#nvme": {
                                    "hwmon-path": "/sys/class/hwmon/hwmon1/temp1_input",
                                    "critical-threshold": 80,
                                    "format": "· NVMe <span color='#aaaaaa'>{temperatureC}°C</span>"
                                  },

                                  "temperature#wifi": {
                                    "hwmon-path": "/sys/class/hwmon/hwmon11/temp1_input",
                                    "critical-threshold": 80,
                                    "format": "· WiFi <span color='#aaaaaa'>{temperatureC}°C</span>"
                                  },

                                  "group/resources": {
                                    "orientation": "horizontal",
                                    "modules": [ "memory", "disk#root" ],
                                    "drawer": {
                                      "transition-left-to-right": false,
                                      "transition-duration": 500
                                    }
                                  },

                                  "memory": {
                                    "interval": 60,
                                    "format": "󰘚 {used:3.1f}GiB/<span color='#aaaaaa'>{total:3.1f}GiB</span>"
                                  },

                                  "disk#root": {
                                    "interval": 360,
                                    "format": "  {used}/<span color='#aaaaaa'>{total}</span>",
                                    "path": "/"
                                  },

                                  "bluetooth": {
                                    // "controller": "controller1",
                                    "on-click": "~/.local/bin/waybar-bluetooth toggle",
                                    "format": "<span color='#aaaaaa'>󰂲</span>",
                                    "format-disabled": "<span color='#333333'></span>",
                                    "format-connected": "",
                                    "format-connected-battery": " {device_battery_percentage}%",
                                    "tooltip-format": "{controller_alias}\t\t[{controller_address}]",
                                    "tooltip-format-connected": "{controller_alias}\t\t[{controller_address}]\n\n{device_enumerate}",
                                    "tooltip-format-connected-battery": "{controller_alias}\t\t[{controller_address}]\n\n{device_enumerate}",
                                    "tooltip-format-enumerate-connected": "{device_alias}\t\t[{device_address}]",
                                    "tooltip-format-enumerate-connected-battery": "{device_alias} ({device_battery_percentage})\t\t[{device_address}]"
                                  },

                                  "group/audio": {
                                    "orientation": "horizontal",
                                    "modules": [ 
                                      "wireplumber", 
                                      "custom/audio-internal",
                                      "custom/audio-headphones",
                                      "custom/audio-hdmi"
                                    ],
                                    "drawer": {
                                      "transition-left-to-right": false,
                                      "transition-duration": 500
                                    }
                                  },

                                  "wireplumber": {
                                    "format": "{icon}  {node_name}/<span color='#aaaaaa'>{volume}</span>",
                                    "format-muted": "",
                                    "on-click": "pavucontrol-qt",
                                    "on-click-right": "helvum",
                                    "format-icons": ["", "", ""]
                                  },

                                  "custom/audio-internal": {
                                    "format": "󱡬 ",
                                    "tooltip-format": "Internal",
                                    "on-click": "audio-router analog",
                                    "interval": "once"
                                  },

                                  "custom/audio-hdmi": {
                                    "format": "󰡁 ",
                                    "tooltip-format": "HDMI",
                                    "on-click": "audio-router hdmi",
                                    "interval": "once"
                                  },

                                  "group/battery": {
                                    "orientation": "horizontal",
                                    "modules": [ 
                                      "battery",
                                      "custom/powerdraw"
                                    ],
                                    "drawer": {
                                      "transition-left-to-right": false,
                                      "transition-duration": 500
                                    }
                                  },

                                  "battery": {
                                    "bat": "BAT1",
                                    "interval": 30,
                                    "states": {
                                      "warning": 20,
                                      "critical": 10
                                    },
                                    "format-time": "{H}:{m}",
                                    "format": "{icon}   {time} <span color='#aaaaaa'>{capacity}%</span>",
                                    "format-discharging": "{icon}   <span color='#aaaaaa'>{capacity}%</span>",
                                    "format-discharging-warning": "{icon}   <span color='#FF5F1F'>{capacity}%</span>",
                                    "format-discharging-critical": "{icon}   <span color='#FF3131'>{capacity}%</span>",
                                    "format-charging": "{icon}   <span color='#DAF7A6'>{capacity}%</span><span color='#aaaaaa'> @ {power:2.0f}W</span>",
                                    "format-full": "󱐥   <span color='#aaaaaa'>{capacity}%</span>",
                                    "format-not-charging": "󱐤   <span color='#aaaaaa'>{capacity}%</span>",
                                    "format-icons": [" ", " ", " ", " ", " "],
                                  },

                		  "custom/powerdraw": {
                                    "interval": 60,
                                    "exec": "~/.local/bin/waybar-powerdraw",
                                  },

                                  "group/clock": {
                                    "orientation": "horizontal",
                                    "modules": [ "custom/clock#minutes", "clock#time", "clock#date" ],
                                    "drawer": {
                                      "transition-left-to-right": false,
                                      "transition-duration": 500
                                    }
                                  },

                                  "clock#date": {
                                    "interval": 60,
                                    "format": " <span color='#ffffff'> {:%a %e %b %Y}</span>",
                                    "tooltip-format": "<big>{:%B %Y}</big>\n<tt>{calendar}</tt>",
                                    "calendar": {
                                      "mode"          : "year",
                                      "mode-mon-col"  : 2,
                                      "weeks-pos"     : "right",
                                      "on-scroll"     : 1,
                                      "format": {
                                        "months":     "<span color='#ffead3'><b>{}</b></span>",
                                        "days":       "<span color='#ecc6d9'><b>{}</b></span>",
                                        "weeks":      "<span color='#99ffdd'><b>W{}</b></span>",
                                        "weekdays":   "<span color='#ffcc66'><b>{}</b></span>",
                                        "today":      "<span color='#ff6699'><b><u>{}</u></b></span>"
                                      }
                                    },
                                    "actions":  {
                                      "on-click-right": "mode",
                                      "on-scroll-up": "shift_up",
                                      "on-scroll-down": "shift_down"
                                    }
                                  },

                                  "clock#time": {
                                    "interval": 60,
                                    "format": "   {:%I:%M %p}",
                                    "actions":  {
                                      "on-scroll-up": "tz_up",
                                      "on-scroll-down": "tz_down"
                                    }
                                  },

                                  "custom/clock#minutes": {
                                    "interval": 60,
                                    "format": "   <span color='#aaaaaa'>{}</span>  ",
                                    "exec": "~/.local/bin/waybar-minutes"
                                  }
                                }
                                ]
      '';
    };
    "/home/${username}/.config/waybar/style.css" = {
      text = ''
                        * {
                          border: none;
                          border-radius: 0;
                          font-family: 'CommitMono Nerd Font';
                          font-weight: 400;
                          font-size: 11px;
                          min-height: 26px;
                          /* margin: 0 0px; */
                        }

                        window#waybar.top {
                          /* background-color: rgba(115, 116, 116, 0.22); */
                          background-color: rgba(0, 0, 0, 0.75);
                          border-bottom: none;
                          color: #eeeeee;
                          transition-property: background-color;
                          transition-duration: .5s;
                        }

                        window#waybar.hidden {
                          opacity: 0.5;
                        }

                        label#window {
                          text-shadow: 0px 0px 3px #18181e;
                        }

                        tooltip {
                          background: rgba(43, 48, 59, 0.5);
                          border: 1px solid rgba(100, 114, 125, 0.5);
                        }

                        tooltip label {
                          color: white;
                        }

                        .modules-left > widget > label,
                        .modules-left > box > widget > label,
                        .modules-right > widget > label,
                        .modules-right > box > widget > label {
                          padding: 0 10px;
                          margin: 0px 0px 0px 10px;
                        }

                        #network, #resourcese {
                          padding: 0px 2px 0px 2px;
                        }

                        #audio, #battery, #clock {
                          padding: 0px 6px 0px 6px;
                        }

                        .drawer-child > label {
                          margin: 0px 10px;
                        }

                        #custom-audio-internal,
                        #custom-audio-motu,
                        #custom-audio-headphones,
                        #custom-audio-hdmi
                        {
                          padding: 4px 2px;
                          border-radius:  0px;
                        }

                        #workspaces {
                          margin: 0px 0px 0px 0px;
                        }

                        #workspaces button {
                          /*padding: 4px 6px;*/
                          padding: 4px 6px;
                          color: #555555;
                          border-radius:  0px;
                          /*min-width: 32px;*/
                        }

                        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */

                        #workspaces button:hover {
                          box-shadow: inherit;
                          text-shadow: inherit;
                          background: transparent;
                          color: #ffffff;
                        }

                        #workspaces button.active {
                          box-shadow: inherit;
                          text-shadow: inherit;
                          background: transparent;
                          color: #ffffff;
                        }

                        #workspaces button.focused {
                          color: #eeeeee;
                        }

                        #workspaces button.focused:hover {
                          color: #ffffff;
                        }

                        #workspaces button.urgent {
                          color: #ffffff;
                          background-color: #e27878;
                        }

                        #language {
                          /* margin: 0px 0px 0px 0px; */
                          color: #cccccc;
                        }

                        #tray {
                          background-color: rgba(0, 0, 0, 0);
                          /* margin-left: 10px; */
                        }

                        #tray image {
                          margin: 0px 10px 0px 0px;
                        }

                        #mode {
                          background-color: rgba(0, 0, 0, 0);
                          border: 2px solid #e2a478;
                          margin: 0px 10px 0px 0px;
                          border-radius: 5px;
                        }

                        #custom-yubikey.icon {
                          background: #f9409d;
                        }

                	#custom-spotify {
                          color: #ffffff;
                          padding-right: 5px;
                        }

                	#custom-devices {
                          color: #ffffff;
        		  padding: 0px 2px 0px 2px;
                        }

                	#custom-powerdraw {
                          color: #ffffff;
                          padding: 0px;
                        }

      '';
    };
  };
}
