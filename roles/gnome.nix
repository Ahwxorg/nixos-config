{
  lib,
  pkgs,
  config,
  username,
  inputs,
  home-manager,
  ...
}:
with lib;
let
  cfg = config.liv.gnome;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.liv.gnome = {
    enable = mkEnableOption "Enable GNOME workflow";
  };

  config = mkIf cfg.enable {
    # security.pam.services.gdm.enableGnomeKeyring = true;
    # services.displayManager.gdm.enable = true;
    # services.desktopManager.gnome.enable = true;
    # services.displayManager.defaultSession = "Hyprland";

    services.gnome.core-apps.enable = false;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.gnome.excludePackages = [
      pkgs.gnome-tour
      pkgs.gnome-user-docs
    ];

    home-manager = {
      users.${username} = {
        home.packages = [
          pkgs.gnomeExtensions.forge
          pkgs.gnomeExtensions.space-bar
          pkgs.gnomeExtensions.cmud
          # pkgs.gnomeExtensions.gocr
          pkgs.gnomeExtensions.pano
          pkgs.gnomeExtensions.pop-shell
        ];
        dconf.enable = true;
        dconf.settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            disabled-extensions = "disabled";
            enabled-extensions = [
              "native-window-placement@gnome-shell-extensions.gcampax.github.com"
              "pop-shell@system76.com"
              "caffeine@patapon.info"
              "hidetopbar@mathieu.bidon.ca"
              "gsconnect@andyholmes.github.io"
              "rounded-window-corners@yilozt.shell-extension.zip"
            ];
            favorite-apps = [
              "firefox.desktop"
              "foot.desktop"
            ];
            had-bluetooth-devices-setup = true;
            remember-mount-password = true;
          };
          "org/gnome/shell/extensions/hidetopbar" = {
            enable-active-window = false;
            enable-intellihide = false;
          };
          "org/gnome/desktop/interface" = {
            clock-show-seconds = false;
            clock-show-weekday = true;
            color-scheme = "prefer-dark";
            enable-hot-corners = true;
            # font-antialiasing = "grayscale";
            # font-hinting = "slight";
            toolkit-accessibility = true;
          };
          "org/gnome/desktop/wm/keybindings" = {
            activate-window-menu = "disabled";
            toggle-message-tray = [ "<Alt>n" ];
            close = [ "<Alt>q" ];
            maximize = [ "<Alt>Up" ];
            minimize = [ "<Alt>comma" ];
            move-to-monitor-down = "disabled";
            move-to-monitor-left = "disabled";
            move-to-monitor-right = "disabled";
            move-to-monitor-up = "disabled";
            move-to-workspace-down = "disabled";
            move-to-workspace-up = "disabled";
            toggle-maximized = [ "<Alt>m" ];
            unmaximize = [ "<Alt>Down" ];
            switch-to-workspace-1 = [ "<Alt>1" ];
            switch-to-workspace-2 = [ "<Alt>2" ];
            switch-to-workspace-3 = [ "<Alt>3" ];
            switch-to-workspace-4 = [ "<Alt>4" ];
            switch-to-workspace-5 = [ "<Alt>5" ];
            switch-to-workspace-6 = [ "<Alt>6" ];
            switch-to-workspace-7 = [ "<Alt>7" ];
            switch-to-workspace-8 = [ "<Alt>8" ];
            switch-to-workspace-9 = [ "<Alt>9" ];
            switch-to-workspace-10 = [ "<Alt>0" ];
            move-to-workspace-1 = [ "<Shift><Alt>1" ];
            move-to-workspace-2 = [ "<Shift><Alt>2" ];
            move-to-workspace-3 = [ "<Shift><Alt>3" ];
            move-to-workspace-4 = [ "<Shift><Alt>4" ];
            move-to-workspace-5 = [ "<Shift><Alt>5" ];
            move-to-workspace-6 = [ "<Shift><Alt>6" ];
            move-to-workspace-7 = [ "<Shift><Alt>7" ];
            move-to-workspace-8 = [ "<Shift><Alt>8" ];
            move-to-workspace-9 = [ "<Shift><Alt>9" ];
            move-to-workspace-10 = [ "<Shift><Alt>0" ];
            cycle-windows = [ "<Alt>s" ];
          };
          # "/org/gnome/shell/keybindings" = {
          # show-screenshot-ui = [ "<Shift><Alt>s" ];
          # };
          "org/gnome/desktop/wm/preferences" = {
            num-workspaces = 10;
            mouse-button-modifier = "<Alt>";
          };
          "org/gnome/shell/extensions/pop-shell" = {
            focus-right = "disabled";
            tile-by-default = true;
            tile-enter = "disabled";
          };
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
            two-finger-scrolling-enabled = true;
          };
          "org/gnome/settings-daemon/plugins/media-keys" = {
            next = [ "<Shift><Control>n" ];
            previous = [ "<Shift><Control>p" ];
            play = [ "<Shift><Control>space" ];
            search = [ "<Alt>d" ];
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
              # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
            ];
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            name = "Open a terminal";
            command = "${pkgs.foot}/bin/foot -e tmux";
            binding = "<Alt>Return";
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
            name = "Open element";
            command = "${pkgs.element-desktop}/bin/element-desktop";
            binding = "<Alt><Shift>e";
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
            name = "Open nautilus";
            command = "${pkgs.nautilus}/bin/nautilus";
            binding = "<Alt>e";
          };
          # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          # name = "Show launcher";
          # command = "${pkgs.bemenu}/bin/bemenu-run -l 5 --ignorecase";
          # binding = "<Alt>d";
          # };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
            name = "Open element";
            command = "${pkgs.firefox}/bin/firefox";
            binding = "<Alt><Shift>f";
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
            name = "Open ungoogled-chromium";
            command = "${pkgs.ungoogled-chromium}/bin/chromium";
            binding = "<Alt><Shift>c";
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
            name = "Open Thunderbird";
            command = "${pkgs.thunderbird}/bin/thunderbird";
            binding = "<Alt><Shift>t";
          };
          "org/gnome/desktop/interface" = {
            accent-color = "purple";
          };
          "org/gnome/desktop/input-sources" = {
            xkb-options = [
              "ctrl:nocaps"
              "lv3:ralt_switch"
              "compose:rwin"
            ];
          };
        };
      };
    };
  };
}
