{
  pkgs,
  host,
  username,
  lib,
  ...
}:
let
  dark = "#040606";
  black = "#241b2f";
  dim = "#495671";
  red = "#f53fa1";
  green = "#72f1b8";
  yellow = "#ffcc00";
  blue = "#2b196e";
  magenta = "#ff7edb"; # previously cda5ef
  cyan = "#61e2ff";
  white = "#f8f8f8";
  bright = "#ffffff";
  transparent = "#ff000000";
  winterBlue = "#252535";
  mod = "Mod1";
  altmod = "Mod4";
  laptop = "eDP-1";
in
{
  home.packages = with pkgs; [
    wmctrl
    waylock
  ];

  wayland.windowManager.sway = {
    checkConfig = false;
    package = pkgs.swayfx;
    enable = true;
    config = {
      output = {
        eDP-1 = {
          scale = "1.25";
        };
      };
      window.border = 4;
      colors = {
        focused = {
          border = magenta;
          background = "#536161";
          text = white;
          indicator = yellow;
          childBorder = "#536161";
        };
        unfocused = {
          border = dark;
          background = dark;
          text = dim;
          indicator = dark;
          childBorder = winterBlue;
        };
        focusedInactive = {
          border = dark;
          background = dark;
          text = white;
          indicator = dark;
          childBorder = winterBlue;
        };
        urgent = {
          border = red;
          background = red;
          text = white;
          indicator = red;
          childBorder = red;
        };
        placeholder = {
          border = dark;
          background = dark;
          text = white;
          indicator = white;
          childBorder = dark;
        };
      };
      fonts = {
        names = [
          "BlexMono Nerd Font"
        ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };
      bars = [ ];
      input = {
        "type:keyboard" = {
          # "*" = {
          xkb_options = "caps:ctrl_modifier";
        };
      };
      modifier = mod;
      keybindings = lib.attrsets.mergeAttrsList [
        (lib.attrsets.mergeAttrsList (
          map
            (
              num:
              let
                ws = toString num;
              in
              {
                "${mod}+${ws}" = "workspace ${ws}";
                "${mod}+Shift+${ws}" = "move container to workspace ${ws}";
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
            # "${mod}+${key}" = "focus parent, focus ${direction}, focus child";
            # "${mod}+Shift+${key}" = "focus parent, move ${direction}, focus child";
            "${mod}+${key}" = "focus ${direction}";
            "${mod}+Shift+${key}" = "move ${direction}";
          })
          {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          }
        )

        {

          "${mod}+q" = "kill";
          "${mod}+w" = "layout split";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+v" = "split v";
          "${mod}+g" = "layout tabbed";
          "${mod}+Space" = "floating toggle";
          "${mod}+Shift+r" = "exec swaymsg reload";
          "${mod}+Tab" = "focus next";
          "${mod}+Shift+Tab" = "focus prev";
          "${altmod}+n" = "focus next";
          "${altmod}+p" = "focus prev";

          "${mod}+d" = "exec --no-startup-id ${pkgs.bemenu}/bin/bemenu-run -l 5 --ignorecase";
          "${mod}+e" = "exec --no-startup-id ${pkgs.nautilus}/bin/nautilus";
          "${mod}+c" = "exec --no-startup-id ${pkgs.hyprpicker}/bin/hyprpicker -a";
          "${mod}+n" = "exec --no-startup-id ${pkgs.swaynotificationcenter}/bin/swaync-client -t";

          "${mod}+Return" = "exec --no-startup-id ${pkgs.foot}/bin/footclient";
          "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.foot}/bin/footclient --title 'float_foot'";
          "${altmod}+Shift+l" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy";
          "${mod}+Shift+b" = "exec pkill -SIGUSR1 .waybar-wrapped";
          "${mod}+Shift+v" = "exec cliphist list | bemenu -l 5 --ignorecase | cliphist decode | wl-copy";
          "${mod}+Shift+f" = "exec --no-startup-id ${pkgs.firefox}/bin/firefox";
          "${mod}+Shift+c" = "exec --no-startup-id ${pkgs.ungoogled-chromium}/bin/chromium";
          "${mod}+Shift+q" = "exec --no-startup-id ${pkgs.qutebrowser}/bin/qutebrowser";
          "${mod}+Shift+w" = "exec --no-startup-id ${pkgs.wdisplays}/bin/wdisplays";
          "${mod}+Shift+t" = "exec --no-startup-id ${pkgs.thunderbird}/bin/thunderbird";
          "${mod}+Shift+e" = "exec --no-startup-id ${pkgs.element-desktop}/bin/element-desktop";
          "${mod}+Shift+p" = "exec --no-startup-id ${pkgs.lxqt.pavucontrol-qt}/bin/pavucontrol-qt";
          "${mod}+Shift+n" = "exec --no-startup-id notes";

          # screenshot
          "${mod}+Shift+s" =
            "exec ${pkgs.grim}/bin/grim -g \"\$(${pkgs.slurp}/bin/slurp)\" -t png - | wl-copy -t image/png";
          # "${mod}+Shift+s" = "exec --no-startup-id grimblast copy area";
          "${mod}+Shift+g" = "exec --no-startup-id grabtext";

          # media and volume controls
          "XF86AudioRaiseVolume" = "exec pamixer -i 2";
          "XF86AudioLowerVolume" = "exec pamixer -d 2";
          "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/playerctl play-pause";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/playerctl next";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/playerctl previous";
          "XF86AudioStop" = "exec ${pkgs.playerctl}/playerctl stop";

          # laptop brigthness
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "${mod}+XF86MonBrightnessUp" = "exec brightnessctl set 100%+";
          "${mod}+XF86MonBrightnessDown" = "exec brightnessctl set 100%-";
        }
      ];
      focus.followMouse = true;
      startup = [
        { command = "systemctl --user import-environment &"; }
        { command = "hash dbus-update-activation-environment 2>/dev/null &"; }
        { command = "dbus-update-activation-environment --systemd &"; }
        { command = "wl-clip-persist --clipboard both"; }
        { command = "awww-daemon &"; }
        { command = "poweralertd &"; }
        { command = "waybar &"; }
        { command = "swaync &"; }
        { command = "wl-paste --watch cliphist store &"; }
        { command = "yubikey-touch-detector --libnotify &"; }
        { command = "mpDris2 &"; }
        # { command = "wlsunset -S '06:30' -s '19:30' -d 1800 "; }
        { command = "foot --server &"; }
        { command = "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"; }
        { command = "xfce4-taskmanager"; }
      ];
      workspaceAutoBackAndForth = false;

      bindswitches = {
        "lid:on" = {
          reload = true;
          locked = true;
          action = "output ${laptop} disable";
        };
        "lid:off" = {
          reload = true;
          locked = true;
          action = "output ${laptop} enable";
        };
      };
    };

    # systemd.enable = true; # why would anyone do this???
    wrapperFeatures = {
      gtk = true;
    };
    extraConfig = ''
      set $font Ubuntu Mono
      font pango:$font 7
      hide_edge_borders none
      title_align left
      default_border normal 2
      for_window [all] border normal 2, floating enable, title_format "<span text_transform='lowercase'>%title</span>"

      for_window [app_id="firefox"]            floating disabled
      for_window [app_id="thudnerbird"]        floating disabled
      for_window [app_id="Element"]            floating disabled
      for_window [app_id="Dino"]               floating disabled
      for_window [app_id="Signal"]             floating disabled
      for_window [app_id="librewolf"]          floating disabled
      for_window [app_id="footclient"]         floating disabled
      for_window [app_id="fl.exe"]             floating disabled

      for_window [class="libreoffice-startcenter"] resize set 1024 720
      for_window [window_role="(?i)GtkFileChooserDialog"] resize 750 500

      #for_window [class="librewolf"],          floating disable
      #for_window [class="foot"],               floating disable
      #for_window [class="Element"],            floating disable
      #for_window [class="dino"],               floating disable
      #for_window [class="Signal"],             floating disable
      #for_window [class="libreoffice-writer"], floating disable
      #for_window [class="libreoffice-calc"],   floating disable
      #for_window [class="libreoffice-draw"],   floating disable
      #for_window [class="libreoffice-math"],   floating disable
      #for_window [class="libreoffice-impress"],floating disable

      for_window [window_role="(?i)GtkFileChooserDialog"] resize set 720 640
      for_window [title="LibreWolf — Sharing Indicator"]    border none

      shadows enable
      shadow_offset 10 10

      # blur enable
      # blur_passes 2
      # lbur_radius 1
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
  };

  home.file.".hm-graphical-session".text = pkgs.lib.concatStringsSep "\n" [
    "export MOZ_ENABLE_WAYLAND=1"
    "export NIXOS_OZONE_WL=1" # Electron
  ];

  programs.sway-easyfocus = {
    enable = true;
    settings = {
      chars = "asdfjkl";
      focused_background_color = "285577";
      focused_background_opacity = 1.0;
      focused_text_color = "ffffff";
      font_family = "BlexMono Nerd Font";
      font_size = "14";
      window_background_color = "d1f21";
      window_background_opacity = 0.2;
    };
  };
}
