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
      home.packages = with pkgs; [
        element-desktop
        dino
        signal-desktop
        mumble
        anki-bin
        obs-studio
        wdisplays
        librewolf # main
        ungoogled-chromium # for things that don't work with librewolf
        nsxiv
        imv
        libreoffice
        xfce.thunar
        # spotify
        spotify-player
        thunderbird
        lxqt.pavucontrol-qt
        mpv
        kdePackages.kdeconnect-kde
        winbox
        # onthespot-overlay

        # Gaming
        lunar-client

        # Not GUI but specific to GUI usage
        sshuttle
        sshfs

        # previously in hyprland config
        # pkgs.nerdfonts
        # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        pkgs.twemoji-color-font
        pkgs.noto-fonts-color-emoji
        pkgs.swww
        pkgs.swaylock
        pkgs.pywal16
      ];
    };
  };
}
