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
in
{
  home.packages = with pkgs; [
    autotiling
    libinput-gestures
    wmctrl
    swaycons
  ];

  wayland.windowManager.sway = {
    checkConfig = false;
    package = pkgs.swayfx;
    enable = true;
    config = {
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
          "GohuFont 11 Nerd Font Mono"
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
            "Mod1+${key}" = "focus parent, focus ${direction}, focus child";
            "Mod1+Ctrl+${key}" = "focus parent, move ${direction}, focus child";
          })
          {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          }
        )

        {

          "Mod1+q" = "kill";
          "Mod1+w" = "layout split";
          "Mod1+f" = "fullscreen toggle";
          "Mod1+s" = "layout stacking";
          # "Mod1+v" = "split v";
          "Mod1+g" = "layout tabbed";
          "Mod1+Space" = "floating toggle";
          "Mod1+Shift+r" = "exec swaymsg reload";
          "Mod1+Tab" = "focus next";
          "Mod1+Shift+Tab" = "focus prev";
          "Mod4+n" = "focus next";
          "Mod4+p" = "focus prev";

          "Mod1+d" = "exec --no-startup-id ${pkgs.bemenu}/bin/bemenu-run -l 5 --ignorecase";
          "Mod1+e" = "exec --no-startup-id thunar";
          "Mod1+c" = "exec --no-startup-id hyprpicker -a";
          "Mod1+n" = "exec --no-startup-id swaync-client -t";

          "Mod1+Return" = "exec --no-startup-id ${pkgs.foot}/bin/footclient";
          "Mod1+Shift+Return" = "exec --no-startup-id ${pkgs.foot}/bin/footclient --title 'float_foot'";
          "Mod1+Shift+l" = "exec --no-startup-id ${pkgs.hyprlock}/bin/hyprlock";
          "Mod4+Shift+l" = "exec swaylock --image /home/${username}/.local/share/bg.png";
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
          "Mod1+Shift+s" = "exec grim -g \"\$(slurp)\" -t png - | wl-copy -t image/png";
          # "Mod1+Shift+s" = "exec --no-startup-id grimblast copy area";
          "Mod1+Shift+g" = "exec --no-startup-id grabtext";

          # media and volume controls
          "XF86AudioRaiseVolume" = "exec pamixer -i 2";
          "XF86AudioLowerVolume" = "exec pamixer -d 2";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioStop" = "exec playerctl stop";

          # laptop brigthness
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "Mod1+XF86MonBrightnessUp" = "exec brightnessctl set 100%+";
          "Mod1+XF86MonBrightnessDown" = "exec brightnessctl set 100%-";
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
        { command = "swaycons &"; }
        # { command = "wlsunset -S '06:30' -s '19:30' -d 1800 "; }
        { command = "foot --server &"; }
        { command = "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"; }
        { command = "footclient"; }
      ];
      workspaceAutoBackAndForth = false;
    };
    # systemd.enable = true; # why would anyone do this???
    wrapperFeatures = {
      gtk = true;
    };
    extraConfig = ''
      set $font Ubuntu Mono
      font pango:$font 7
      set $title_options text_transform='lowercase'

      # window styles
      hide_edge_borders none
      # title_align left
      # default_border normal 4
      # for_window [all] border normal 4, floating enable

      # for_window [class="librewolf"], floating disable
      # for_window [class="foot"], floating disable
      # for_window [class="Element"], floating disable
      # for_window [class="dino"], floating disable
      # for_window [class="Signal"], floating disable
      # for_window [class="libreoffice-writer"]  floating disable
      # for_window [class="libreoffice-calc"]    floating disable
      # for_window [class="libreoffice-draw"]    floating disable
      # for_window [class="libreoffice-math"]    floating disable
      # for_window [class="libreoffice-impress"] floating disable

      for_window [window_role="(?i)GtkFileChooserDialog"] resize set 720 640
      for_window [title="LibreWolf — Sharing Indicator"]    border none
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
      font_family = "GohuFont 14 Nerd Font Mono";
      font_size = "14";
      window_background_color = "d1f21";
      window_background_opacity = 0.2;
    };
  };

  home.file."/home/${username}/.config/swaycons/config.toml".text = ''
    [global]
    color = "#FFFFFF"
    focused_color = "#FFFFFF"
    icon = "󰖯"
    size = "14pt"
    separator = " "

    [app_id]
    "dev.alextren.Spot" = { icon = "󰓇", color = "#1ed760" }
    "org.daa.NeovimGtk" = { icon = "", color = "#8fff6d" }
    "org.gnome.Calculator" = { icon = "󰃬" }
    "org.gnome.clocks" = { icon = "󱑈" }
    "org.gnome.Nautilus" = { icon = "󰉖", color = "#6291d6" }
    "im.dino.Dino" = { icon = "󰭹", color = "#3777f0" }
    spt = { icon = "󰋋", color = "#ef5466" }
    rmpc = { icon = "󰋋", color = "#ef5466" }
    Signal = { icon = "󰭹", color = "#3777f0" }
    Element = { icon = "󰭹", color = "#3777f0" }
    Spotify = { icon = "󰓇", color = "#1ed760" }
    chromium = { icon = "", color = "#a1c2fa", size = "13pt" }
    librewolf = { icon = "", color = "#ff8817", size = "13pt" }
    foot = { icon = "" }
    thunderbird = { icon = "", color = "#f6d32d" }
    neovide = { icon = "", color = "#8fff6d" }
    nvim-qt = { icon = "", color = "#8fff6d" }
    libreoffice-writer = { icon = "", color = "#00A500", size = "12pt" }
    libreoffice-calc = { icon = "󰱿", color = "#00A500" }

    [title]
    "(?i)Thunar" = { icon = "󰉖", color = "#6291d6" }
    "(?i)vim" = { app_id = ["foot", "kitty"], icon = "", color = "#8fff6d" }
    "(cloud|developers)\\.google.com" = { icon = "", color = "#4285f4" }
    "192\\.168\\.0\\.1|192\\.168\\.86\\.1|ui\\.com" = { icon = "󰖩", color = "#004cb6" }
    "1password\\.com" = { icon = "󰍁", color = "#0572ec" }
    "amazon\\.com" = { icon = "", color = "#ff9900" }
    "angular\\.io" = { icon = "", color = "#dd0031" }
    "archlinux\\.org" = { icon = "", color = "#1793d1" }
    "atlassian\\.(net|com)" = { icon = "󰌃", color = "#0052cc" }
    "aws\\.amazon\\.com" = { icon = "", color = "#ff9900" }
    "bitbucket\\.org" = { icon = "󰂨", color = "#0052cc" }
    "calendar\\.google\\.com" = { icon = "󰃶", color = "#4285f4" }
    "coda\\.io" = { icon = "", color = "#f46a54" }
    "crates\\.io" = { icon = "󰏗", color = "#ffc933" }
    "deezer\\.com" = { icon = "󰋋", color = "#ef5466" }
    "discogs\\.com" = { icon = "󰀥" }
    "discord\\.com" = { icon = "󰙯", color = "#404eed" }
    "docs\\.google\\.com" = { icon = "", color = "#4285f4" }
    "docs\\.google\\.com/spreadsheets" = { icon = "󰈛", color = "#34a853" }
    "docs\\.rs|rust-lang\\.org" = { icon = "", size = "16pt" }
    "drive\\.google\\.com" = { icon = "󰊶", color = "#4285f4" }
    "dropbox\\.com" = { icon = "󰇣", color = "#0061fe" }
    "duckduckgo\\.com" = { icon = "󰇥", color = "#de5833" }
    "facebook\\.com" = { icon = "", color = "#1877f2" }
    "fastmail\\.com" = { icon = "󰗰", color = "#1565c0" }
    "fastmail\\.com/calendar" = { icon = "", color = "#1565c0" }
    "fastmail\\.com/contacts" = { size = "11pt", icon = "", color = "#1565c0" }
    "feedbin\\.com" = { icon = "" }
    "gitbook\\.com" = { icon = "", color = "#346ddb" }
    "github\\.com" = { icon = "" }
    "google\\.com" = { icon = "", color = "#4285f4" }
    "google\\.com/maps" = { icon = "󰗵", color = "#4caf50" }
    "insomnia\\.rest" = { icon = "", color = "#7100df" }
    "keep\\.google\\.com" = { icon = "󰛜", color = "#fbbc04" }
    "last\\.fm" = { icon = "", color = "#ba0000" }
    "mail\\.google\\.com" = { icon = "󰊫", color = "#ad1f1c" }
    "meet\\.google\\.com" = { icon = "", color = "#4285f4" }
    "messages\\.google\\.com" = { icon = "󰍩", color = "#4285f4" }
    "mozilla\\.org" = { icon = "" }
    "nerdfonts\\.com" = { icon = "", color = "#ffce3e" }
    "nytimes\\.com/games/wordle" = { icon = "󰈭", color = "#538d4e" }
    "photos\\.google\\.com" = { icon = "󰄄", color = "#4285f4" }
    "reactjs\\.org" = { icon = "", color = "#61dafb" }
    "reddit\\.com" = { icon = "󰑍", color = "#ff4500" }
    "slack\\.com" = { icon = "󰒱", color = "#2eb67d" }
    "sleeper\\.com" = { icon = "󰉟", color = "#7c8ef4" }
    "spotify\\.com" = { icon = "󰓇", color = "#1ed760" }
    "sr\\.ht|sourcehut\\.org" = { icon = "" }
    "stackoverflow\\.com" = { icon = "", color = "#f48225" }
    "startpage\\.com" = { icon = "", color = "#6573ff" }
    "stripe\\.com" = { icon = "", color = "#635bff" }
    "ticktick\\.com" = { icon = "󰄴", color = "#4774f9" }
    "todoist\\.com" = { icon = "󰄲", color = "#e44232" }
    "travis-ci\\.(com|org)" = { icon = "", color = "#cd324a" }
    "twitter\\.com" = { icon = "", color = "#1d9bf0" }
    "webpack\\.js\\.org" = { icon = "󰆧", color = "#8ed6fb" }
    "wikipedia\\.org" = { icon = "" }
    "youneedabudget\\.com" = { icon = "", color = "#4495d7" }
    "bandcamp\\.com" = { icon = "", color = "#1da0c3", size = "13pt" }
    "zoom\\.us" = { icon = "󰕧", color = "#2d8cff" }
    aerc = { app_id = ["foot", "Alacritty"], icon = "󰇰" }
    litecli = { app_id = ["foot", "Alacritty"], icon = "󰆼", color = "#c74451" }
    nnn = { app_id = ["foot", "Alacritty"], icon = "󰉖" }
    pgcli = { app_id = ["foot", "Alacritty"], icon = "󰆼", color = "#c74451" }
  '';
  home.file = {
    "/home/${username}/.config/libinput-gestures/sway.conf" = {
      executable = false;
      text = "
       Cycle right through sway workspaces
       gesture: swipe right 3 swaymsg focus right
  
       # Cycle left through sway workspaces
       gesture: swipe left 3 swaymsg focus left
     ";
    };
  };
}
