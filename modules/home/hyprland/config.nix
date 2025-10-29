{
  pkgs,
  host,
  username,
  ...
}:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    # pkgs.nerdfonts
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.twemoji-color-font
    pkgs.noto-fonts-emoji
    pkgs.swww
    pkgs.swaylock
    pkgs.pywal16
  ];

  gtk = {
    enable = true;
    font = {
      name = "GohuFont 14 Nerd Font Mono";
      size = 14;
    };
    theme = {
      name = "Juno";
      package = pkgs.juno-theme; # .override {
      # colorVariants = [ "dark" ];
      # themeVariants = [ "green" ];
      # tweakVariants = [ "macos" ];
      # };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "black";
      };
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  wayland.windowManager.hyprland = {
    settings = {

      source = "~/nixos-config/modules/home/hyprland/displays.conf";

      "debug:disable_scale_checks" = true;
      monitor =
        if (host == "sakura") then
          "eDP-1, 2256x1504@60, 0x0, 1.0"
        else if (host == "zinnia") then
          "eDP-1, 1920x1080@60, 0x0, 1.0"
        else if (host == "imilia") then
          "eDP-1, 1920x1080@60, 0x0, 1.0"
        else
          ", preferred, auto, 1";

      # autostart
      exec-once = [
        "systemctl --user import-environment &"
        "hash dbus-update-activation-environment 2>/dev/null &"
        "dbus-update-activation-environment --systemd &"
        "wl-clip-persist --clipboard both"
        "swww-daemon &"
        "poweralertd &"
        "waybar &"
        "swaync &"
        "wl-paste --watch cliphist store &"
        "yubikey-touch-detector --libnotify &"
        "mpDris2 &"
        "foot --server &"
        "hyprfloat &"
      ];

      input = {
        kb_layout = "us,jp";
        kb_options = "caps:ctrl_modifier";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      #gestures = {
      #  workspace_swipe = true;
      #  workspace_swipe_invert = true;
      #};

      general = {
        "$mainMod" = "ALT";
        layout = "dwindle";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgb(ffffff) rgb(ffffff) 45deg";
        "col.inactive_border" = "0x00000000";
        no_border_on_floating = false;
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
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = false;
          size = 1;
          passes = 1;
          # size = 4;
          # passes = 2;
          brightness = 1;
          contrast = 1.400;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
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
        "3, horizontal, workspace"
        # "4, horizontal, move"
      ];

      bind = [
        # keybindings
        "$mainMod, Return, exec, footclient"
        "$mainMod SHIFT, Return, exec, [float; center; size 950 650] footclient --title 'float_foot'"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 0" # set 1 to 0 to set full screen without waybar
        "$mainMod, Space, togglefloating,"
        "$mainMod, D, exec, bemenu-run -l 5 --ignorecase"
        "SUPER SHIFT, L, exec, swaylock --image /home/${username}/.local/share/bg.png"
        "$mainMod, E, exec, thunar"
        "$mainMod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
        "$mainMod, C,exec, hyprpicker -a"
        "$mainMod, W,exec, wallpaper-picker"
        "$mainMod, G, togglegroup,"
        "SUPER, N, changegroupactive, f"
        "SUPER, P, changegroupactive, b"
        "$mainMod, Tab, changegroupactive, f"
        "$mainMod SHIFT, Tab, changegroupactive, b"

        # password manager
        "$mainMod SHIFT, X, exec, footclient --title 'float_foot' zsh -c 'bash ~/.local/src/bw-fzf/bw-fzf.sh"

        # clipboard manager
        "$mainMod SHIFT, V, exec, cliphist list | bemenu -l 5 --ignorecase | cliphist decode | wl-copy"

        "$mainMod SHIFT, F, exec, librewolf"
        "$mainMod SHIFT, C, exec, chromium"
        "$mainMod SHIFT, Q, exec, qutebrowser"
        "$mainMod SHIFT, W, exec, wdisplays"
        "$mainMod SHIFT, T, exec, thunderbird"
        "$mainMod SHIFT, E, exec, element-desktop"
        "$mainMod SHIFT, P, exec, pavucontrol-qt"
        "$mainMod SHIFT, N, exec, notes"
        "$mainMod      , N, exec, swaync-client -t"

        # screenshot
        "SUPER SHIFT, S, exec, grimblast save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
        "$mainMod SHIFT, S, exec, grimblast copy area"
        "$mainMod SHIFT, G, exec, grabtext"

        # switch focus
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # switch to workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # move to workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # window control
        #  "$mainMod SHIFT, left, movewindow, l"
        #  "$mainMod SHIFT, right, movewindow, r"
        #  "$mainMod SHIFT, up, movewindow, u"
        #  "$mainMod SHIFT, down, movewindow, d"
        #  "$mainMod CTRL, left, resizeactive, -80 0"
        #  "$mainMod CTRL, right, resizeactive, 80 0"
        #  "$mainMod CTRL, up, resizeactive, 0 -80"
        #  "$mainMod CTRL, down, resizeactive, 0 80"
        #  "$mainMod ALT, left, moveactive,  -80 0"
        #  "$mainMod ALT, right, moveactive, 80 0"
        #  "$mainMod ALT, up, moveactive, 0 -80"
        #  "$mainMod ALT, down, moveactive, 0 80"

        # media and volume controls
        ",XF86AudioRaiseVolume,exec, pamixer -i 2"
        ",XF86AudioLowerVolume,exec, pamixer -d 2"
        ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # laptop brigthness
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      # windowrule
      windowrule = [
        "float,title:^(float_kitty)$"
        "center,title:^(float_kitty)$"
        "size 950 600,title:^(float_kitty)$"
        "float,title:^(float_foot)$"
        "center,title:^(float_foot)$"
        "size 950 600,title:^(float_foot)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Librewolf — Sharing Indicator)$"
        "float,title:^(Export Image as PNG)$"
        "move 0 0,title:^(Librewolf — Sharing Indicator)$"
        "size 700 450,title:^(Volume Control)$"
        "move 40 55%,title:^(Volume Control)$"
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      # windowrulev2
      windowrulev2 = [
        "noanim, class:^(bemenu)$"
        "float, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(librewolf)$"
        "float,class:^(pavucontrol-qt)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(SoundWireServer)$"
        "float,class:^(.sameboy-wrapped)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,title:^(float_foot)$"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
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
