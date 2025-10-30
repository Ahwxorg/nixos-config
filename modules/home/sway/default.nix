{
  pkgs,
  host,
  username,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    autotiling
    libinput-gestures
    wmctrl
  ];

  wayland.windowManager.sway = {
    checkConfig = false;
    package = pkgs.swayfx;
    enable = true;
    config = {
      #input = {
      #  "type:keyboard" = {
      #    xbk_options = "caps:ctrl_modifier";
      #  };
      #};
      modifier = "Mod1";
      keybindings = lib.attrsets.mergeAttrsList [
        (lib.attrsets.mergeAttrsList (
          map
            (
              num:
              let
                ws = toString num;
              in
              {
                "Mod1+${ws}" = "workspace ${ws}";
                "Mod1+Ctrl+${ws}" = "move container to workspace ${ws}";
              }
            )
            [
              1
              2
              3
              4
              5
              6
              7
              8
              9
              0
            ]
        ))

        (lib.attrsets.concatMapAttrs
          (key: direction: {
            "Mod1+${key}" = "focus ${direction}";
            "Mod1+Ctrl+${key}" = "move ${direction}";
          })
          {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          }
        )

        {

          # "Mod1+q" = "kill";
          # "Mod1+e" = "layout toggle split";
          # "Mod1+f" = "fullscreen toggle";
          # "Mod1+g" = "split h";
          # "Mod1+s" = "layout stacking";
          # "Mod1+v" = "split v";
          # "Mod1+w" = "layout tabbed";
          # "Mod1+Space" = "floating toggle";
          # "Mod1+Shift+r" = "exec swaymsg reload";
          "Mod1+g" = " togglegroup";
          "Mod1+Tab" = "focus next";
          "Mod1+Shift+Tab" = "focus prev";
          "Mod4+n" = "focus next";
          "Mod4+p" = "focus prev";

          "Mod1+d" = "exec --no-startup-id ${pkgs.bemenu}/bin/bemenu-run -l 5 --ignorecase";
          "Mod1+e" = "exec --no-startup-id thunar";
          "Mod1+c" = "exec --no-startup-id hyprpicker -a";
          "Mod1+w" = "exec --no-startup-id wallpaper-picker";
          "Mod1+n" = "exec --no-startup-id swaync-client -t";

          "Mod1+Return" = "exec --no-startup-id ${pkgs.foot}/bin/footclient";
          "Mod1+Shift+Return" = "exec --no-startup-id ${pkgs.foot}/bin/footclient --title 'float_foot'";
          "Mod1+Ctrl+l" = "exec --no-startup-id ${pkgs.hyprlock}/bin/hyprlock";
          "Mod4+Ctrl+l" = "exec swaylock --image /home/${username}/.local/share/bg.png";
          "Mod1+Shift+b" = "exec pkill -SIGUSR1 .waybar-wrapped";
          "Mod1+Shift+v" = "exec cliphist list | bemenu -l 5 --ignorecase | cliphist decode | wl-copy";
          "Mod1+Shift+f" = "exec --no-startup-id librewolf";
          "Mod1+Shift+c" = "exec --no-startup-id chromium";
          "Mod1+Shift+q" = "exec --no-startup-id qutebrowser";
          "Mod1+Shift+w" = "exec --no-startup-id wdisplays";
          "Mod1+Shift+t" = "exec --no-startup-id thunderbird";
          "Mod1+Shift+e" = "exec --no-startup-id element-desktop";
          "Mod1+Shift+p" = "exec --no-startup-id pavucontrol-qt";
          "Mod1+Shift+n" = "exec --no-startup-id notes";

          # screenshot
          "Mod1+Shift+s" = "exec --no-startup-id grimblast copy area";
          "Mod1+Shift+g" = "exec --no-startup-id grabtext";

          # media and volume controls
          # ",XF86AudioRaiseVolume,exec, pamixer -i 2"
          # ",XF86AudioLowerVolume,exec, pamixer -d 2"
          # ",XF86AudioMute,exec, pamixer -t"
          # ",XF86AudioPlay,exec, playerctl play-pause"
          # ",XF86AudioNext,exec, playerctl next"
          # ",XF86AudioPrev,exec, playerctl previous"
          # ",XF86AudioStop, exec, playerctl stop"
          # "Mod1, mouse_down, workspace, e-1"
          # "Mod1, mouse_up, workspace, e+1"

          # # laptop brigthness
          # ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          # ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          # "Mod1, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
          # "Mod1, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
        }
      ];
      focus.followMouse = true;
      startup = [
        { command = "systemctl --user import-environment &"; }
        { command = "hash dbus-update-activation-environment 2>/dev/null &"; }
        { command = "dbus-update-activation-environment --systemd &"; }
        { command = "wl-clip-persist --clipboard both"; }
        { command = "swww-daemon &"; }
        { command = "poweralertd &"; }
        { command = "waybar &"; }
        { command = "swaync &"; }
        { command = "wl-paste --watch cliphist store &"; }
        { command = "yubikey-touch-detector --libnotify &"; }
        { command = "mpDris2 &"; }
        { command = "foot --server &"; }
        { command = "footclient"; }
      ];
      workspaceAutoBackAndForth = true;
    };
    # systemd.enable = true; # ???
    wrapperFeatures = {
      gtk = true;
    };
  };

  home.file.".hm-graphical-session".text = pkgs.lib.concatStringsSep "\n" [
    "export MOZ_ENABLE_WAYLAND=1"
    "export NIXOS_OZONE_WL=1" # Electron
  ];

  services.kanshi = {
    enable = true;

    profiles = {
      laptops = {
        outputs =
          if (host == "sakura") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else if (host == "zinnia") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else if (host == "imilia") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ];
      };
    };
  };
}

#home.file = {
#  "/home/${username}/.config/libinput-gestures/sway.conf" = {
#    executable = false;
#    text = "
#      # Cycle right through sway workspaces
#      gesture: swipe right 3 swaymsg focus right

#      # Cycle left through sway workspaces
#      gesture: swipe left 3 swaymsg focus left
#    ";
#  };
#};
