{
  pkgs,
  host,
  username,
  inputs,
  ...
}:
{
  imports = [
    ./hyprland.nix
  ];

  services.swayosd.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      "debug:disable_scale_checks" = true;
      monitor =
        if (host == "fw13") then
          "eDP-1, 2256x1504@60, 0x0, 1.0"
        else if (host == "sakura") then
          "eDP-1, 1920x1200@60, 0x0, 1.0"
        else if (host == "zinnia") then
          "eDP-1, 1920x1080@60, 0x0, 1.0"
        else if (host == "imilia") then
          "eDP-1, 1920x1080@60, 0x0, 1.0"
        else if (host == "fragile") then
          "eDP-1, 3024x1964@120, 0x0, 1.5"
        else
          ", preferred, auto, 1";

      # autostart
      exec-once = [
        "systemctl --user import-environment &"
        "hash dbus-update-activation-environment 2>/dev/null &"
        "dbus-update-activation-environment --systemd &"
        "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both"
        "swww-daemon &"
        "poweralertd &"
        "waybar &"
        "swaync &"
        "wl-paste --watch cliphist store &"
        "yubikey-touch-detector --libnotify &"
        "mpDris2 &"
        "foot --server &"
        "hyprfloat &"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' &"
        "nextcloud &"
        "swayosd-server &"
      ];

      input = {
        kb_layout = "us,jp";
        kb_options = "caps:ctrl_modifier,compose:ralt";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0.01;
        touchpad = {
          natural_scroll = true;
          tap-to-click = false;
          clickfinger_behavior = true;
          disable_while_typing = true;
        };
      };

      #workspace = [
      #  "w[tv1], gapsout:0, gapsin:0"
      #  "f[1], gapsout:0, gapsin:0"
      #];
      general = {
        # "ALT" = "ALT";
        layout = "dwindle";
        gaps_in = 0;
        # gaps_out = "0,0,68,0";
        gaps_out = "0,0,0,0";
        border_size = 2;
        "col.active_border" = "rgb(ffffff) rgb(ffffff) 45deg";
        "col.inactive_border" = "0x00000000";
      };
      group = {
        "col.border_active" = "rgb(ffffff) rgb(ffffff) 45deg";
        "col.border_inactive" = "0x00000000";
        groupbar = {
          font_family = "GohuFont 11 Nerd Font Mono";
          font_size = 11;
          "col.active" = "rgb(efa8a5) rgb(efa8a5) 45deg";
          "col.inactive" = "rgb(a5ecef) rgb(a5ecef) 45deg";
        };
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        enable_anr_dialog = false;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      dwindle = {
        # no_gaps_when_only = true; # Returns errors for some reason
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        special_scale_factor = 1;
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.00;
        inactive_opacity = 1.00;
        # inactive_opacity = 0.75;
        # fullscreen_opacity = 1.0;

        shadow = {
          enabled = true;
          render_power = 4;
          ignore_window = true;
          # offset = [ ];
        };

        blur = {
          enabled = true;
          size = 7;
          passes = 3;
          noise = 0.08;
          brightness = 1;
          contrast = 1.5;
          ignore_opacity = true;
          new_optimizations = true;
          xray = false;
        };

        # drop_shadow = true;

        # shadow_ignore_window = true;
        # shadow_offset = "0 2";
        # shadow_range = 20;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(00000055)";
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          # Windows
          "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
          "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
          "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 2, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 0, 1, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces, 1, 4, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      gesture = [
        "3, left, dispatcher, changegroupactive, b"
        "3, right, dispatcher, changegroupactive, f"
        "4, horizontal, workspace"
        "4, pinchin, fullscreen"
        "4, pinchout, float"
      ];

      bind = [
        # keybindings
        "ALT, Return, exec, footclient"
        "ALT SHIFT, Return, exec, [float; center; size 950 650] footclient --title 'float_foot'"
        "ALT, Q, killactive,"
        "ALT, F, fullscreen, 0" # set 1 to 0 to set full screen without waybar
        "SUPER, F, fullscreen, 1" # set 1 to 0 to set full screen without waybar
        "ALT, Space, togglefloating,"
        "ALT, D, exec, bemenu-run -l 5 --ignorecase"
        "SUPER, L, exec, ${pkgs.swaylock}/bin/swaylock -i ~/.local/share/bg.png --indicator-idle-visible"
        "ALT, E, exec, nautilus"
        "ALT SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
        "ALT, C,exec, hyprpicker -a"
        "ALT, W,exec, wallpaper-picker"
        "ALT, G, togglegroup,"
        "SUPER, N, changegroupactive, f"
        "SUPER, P, changegroupactive, b"
        "ALT, Tab, changegroupactive, f"
        "ALT SHIFT, Tab, changegroupactive, b"

        # clipboard manager
        "ALT SHIFT, V, exec, cliphist list | bemenu -l 5 --ignorecase | cliphist decode | wl-copy"

        "ALT SHIFT, F, exec, firefox"
        "ALT SHIFT, C, exec, chromium"
        "ALT SHIFT, Q, exec, qutebrowser"
        "ALT SHIFT, W, exec, wdisplays"
        "ALT SHIFT, T, exec, thunderbird"
        "ALT SHIFT, E, exec, element-desktop"
        "ALT SHIFT, P, exec, pavucontrol-qt"
        "ALT SHIFT, N, exec, notes"
        "ALT      , N, exec, swaync-client -t"

        # screenshot
        "SUPER SHIFT, S, exec, grimblast save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
        "ALT SHIFT, S, exec, grimblast copy area"
        "ALT SHIFT, G, exec, grabtext"

        # switch focus
        "ALT, H, movefocus, l"
        "ALT, L, movefocus, r"
        "ALT, K, movefocus, u"
        "ALT, J, movefocus, d"

        "ALT SHIFT, H, movewindow, l"
        "ALT SHIFT, L, movewindow, r"
        "ALT SHIFT, K, movewindow, u"
        "ALT SHIFT, J, movewindow, d"

        # switch to workspace
        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"
        "ALT, F1, workspace, name:garbage"
        "ALT, F2, workspace, name:misc"
        "ALT, F3, workspace, name:🛒"
        "ALT, F4, workspace, name:📹"

        # move to workspace
        "ALT SHIFT, 1, movetoworkspacesilent, 1"
        "ALT SHIFT, 2, movetoworkspacesilent, 2"
        "ALT SHIFT, 3, movetoworkspacesilent, 3"
        "ALT SHIFT, 4, movetoworkspacesilent, 4"
        "ALT SHIFT, 5, movetoworkspacesilent, 5"
        "ALT SHIFT, 6, movetoworkspacesilent, 6"
        "ALT SHIFT, 7, movetoworkspacesilent, 7"
        "ALT SHIFT, 8, movetoworkspacesilent, 8"
        "ALT SHIFT, 9, movetoworkspacesilent, 9"
        "ALT SHIFT, 0, movetoworkspacesilent, 10"
        "ALT SHIFT, F1, movetoworkspace, name:garbage"
        "ALT SHIFT, F2, movetoworkspace, name:misc"
        "ALT SHIFT, F3, movetoworkspace, name:🛒"
        "ALT SHIFT, F4, movetoworkspace, name:📹"

        # media and volume controls
        # ",XF86AudioRaiseVolume,exec, pamixer -i 2"
        # ",XF86AudioLowerVolume,exec, pamixer -d 2"
        ",XF86AudioRaiseVolume,exec, swayosd-client --output-volume +2"
        ",XF86AudioLowerVolume,exec, swayosd-client --output-volume -2"
        ",XF86AudioMute,exec, swayosd-client --output-volume mute-toggle"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"

        # laptop brigthness
        ",XF86MonBrightnessUp, exec, swayosd-client --brightness +5"
        ",XF86MonBrightnessDown, exec, swayosd-client --brightness -5"
        "ALT, XF86MonBrightnessUp, exec, swayosd-client --brigthness +100"
        "ALT, XF86MonBrightnessDown, exec, swayosd-client --brigthness 1"

        # mouse controls
        "ALT, mouse_down, workspace, e-1"
        "ALT, mouse_up, workspace, e+1"
      ];

      bindl = [
        ",switch:[Lid Switch], exec, hyprlock"
      ];

      # mouse binding
      bindm = [
        "ALT, mouse:272, movewindow"
        "ALT, mouse:273, resizewindow"
      ];

      # windowrule
      # windowrule = [
      #  "float,title:^(float_kitty)$"
      #  "center,title:^(float_kitty)$"
      #  "size 950 600,title:^(float_kitty)$"
      #  "float,title:^(float_foot)$"
      #  "center,title:^(float_foot)$"
      #  "size 950 600,title:^(float_foot)$"
      #  "float,title:^(Volume Control)$"
      #  "float,title:^(Librewolf — Sharing Indicator)$"
      #  "float,title:^(Export Image as PNG)$"
      #  "move 0 0,title:^(Librewolf — Sharing Indicator)$"
      #  "size 700 450,title:^(Volume Control)$"
      #  "move 40 55%,title:^(Volume Control)$"
      #  "bordersize 0, floating:0, onworkspace:w[tv1]"
      #  "rounding 0, floating:0, onworkspace:w[tv1]"
      #  "bordersize 0, floating:0, onworkspace:f[1]"
      #  "rounding 0, floating:0, onworkspace:f[1]"
      # ];

      ## windowrulev2
      windowrule = [
        # "no_blur on, match:class ungoogled-chromium"
        # "no_blur on, match:class librewolf"
        # "no_screen_share on, match:class element-desktop"
        # "match:title ^(.*Bitwarden Password Manager.*)$, float on"
        # "match:title ^(Picture-in-Picture)$, float on"
        # "match:title ^(Picture-in-Picture)$, pin on"
        # stop idle when watching videos
        # "match:class ^(mpv|.+exe|celluloid)$, idle_inhibit focus"
        # "match:class ^(chromium)$, match:title ^(.*YouTube.*)$, idle_inhibit focus"
        # "match:class ^(chromium)$, idle_inhibit fullscreen"
        #  "noanim, class:^(bemenu)$"
        #  "float, title:^(Picture-in-Picture)$"
        #  "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        #  "pin, title:^(Picture-in-Picture)$"
        #  "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        #  "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        #  "idleinhibit focus, class:^(mpv)$"
        #  "idleinhibit fullscreen, class:^(librewolf)$"
        #  "float,class:^(pavucontrol-qt)$"
        #  "fullscreen,class:Nsxiv"
        #  "fullscreen,title:^(*nsxiv*)$"
        #  "fullscreen,title:^(nsxiv)$"
        #  "fullscreen,class:swiv"
        #  "fullscreen,title:^(*swiv*)$"
        #  "fullscreen,title:^(swiv)$"
        #  "float,class:^(pavucontrol)$"
        #  "float,class:^(SoundWireServer)$"
        #  "float,class:^(.sameboy-wrapped)$"
        #  "float,class:^(file_progress)$"
        #  "float,class:^(confirm)$"
        #  "float,class:^(dialog)$"
        #  "float,class:^(download)$"
        #  "float,class:^(notification)$"
        #  "float,class:^(error)$"
        #  "float,class:^(confirmreset)$"
        #  "float,title:^(Open File)$"
        #  "float,title:^(branchdialog)$"
        #  "float,title:^(Confirm to replace files)$"
        #  "float,title:^(File Operation Progress)$"
        #  "float,title:^(float_foot)$"
        #  "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };

    extraConfig = "
      # If desktop
      input:accel_profile=flat

      input {
        force_no_accel = true
      }

      monitor=,preferred,auto,auto

      # debug:disable_logs = false

      xwayland {
        force_zero_scaling = true
      }

      plugin {
        hyprbars {
          bar_height = 38
          bar_color = rgb(1e1e1e)
          col.text = $foreground
          bar_text_size = 12
          bar_text_font = GohuFont 11 Nerd Font Propo
          bar_button_padding = 12
          bar_padding = 10
          bar_precedence_over_border = true
          hyprbars-button = $color1, 20, , hyprctl dispatch killactive
          hyprbars-button = $color3, 20, , hyprctl dispatch fullscreen 2
          hyprbars-button = $color4, 20, , hyprctl dispatch togglefloating
        }
      }
    ";
  };
}
