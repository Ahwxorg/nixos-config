{
  lib,
  pkgs,
  config,
  username,
  home-manager,
  ...
}:
with lib;
let
  cfg = config.liv.gui;
in
{
  options.liv.gui = {
    enable = mkEnableOption "Enable GUI workflow";
  };

  config = mkIf cfg.enable {
    # security.pam.services.greetd.enableGnomeKeyring = true; # not using greetd
    hardware.graphics.enable = true;
    services = {
      gvfs = {
        enable = true;
        package = lib.mkForce pkgs.gnome.gvfs;
      };
      gnome.gnome-keyring.enable = true;
      dbus.enable = true;
    };
    home-manager.users.${username} = {
      fonts.fontconfig.enable = true;
      gtk = {
        # gtk4.theme = config.gtk.theme;
        enable = true;
        font = {
          name = "GohuFont 14 Nerd Font Mono";
          size = 14;
        };
        theme = {
          name = "Orchis-Purple-Dark-Compact";
          package = pkgs.orchis-theme;
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
      home.packages = [
        pkgs.dconf
        pkgs.element-desktop
        pkgs.dino
        pkgs.signal-desktop
        pkgs.mumble
        pkgs.anki
        pkgs.wdisplays
        pkgs.librewolf
        pkgs.ungoogled-chromium
        pkgs.nsxiv
        pkgs.imv
        pkgs.libreoffice
        pkgs.nautilus
        pkgs.spotify-player
        pkgs.thunderbird
        pkgs.lxqt.pavucontrol-qt
        pkgs.mpv
        pkgs.kdePackages.kdeconnect-kde
        pkgs.libgnome-keyring
        pkgs.foot
        pkgs.nautilus
        pkgs.tesseract
        pkgs.yubikey-touch-detector
        pkgs.wireguard-tools
        pkgs.openresolv
        pkgs.xdg-utils
        pkgs.killall
        pkgs.libnotify
        pkgs.openssl
        pkgs.pamixer
        pkgs.playerctl
        pkgs.wl-clipboard
        pkgs.cliphist
        pkgs.poweralertd

        # Gaming
        # lunar-client

        # Not GUI but specific to GUI usage
        pkgs.sshuttle
        pkgs.sshfs

        # pkgs.nerdfonts
        # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        pkgs.twemoji-color-font
        pkgs.noto-fonts-color-emoji
        pkgs.swww
        pkgs.pywal16
      ];
    };
  };
}
