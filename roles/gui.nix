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
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      dbus.enable = true;
    };

    home-manager.users.${username}.home.packages = with pkgs; [
      element-desktop
      gajim
      signal-desktop
      anki-bin
      obs-studio
      wdisplays
      librewolf # main
      ungoogled-chromium # for things that don't work with librewolf
      nsxiv
      imv
      libreoffice
      xfce.thunar
      spotify
      spotify-player
      thunderbird
      lxqt.pavucontrol-qt
      mpv
      plasma5Packages.kdeconnect-kde
      winbox
      # onthespot-overlay

      # Gaming
      lunar-client

      # Not GUI but specific to GUI usage
      sshuttle
      sshfs

      # try out for a bit
      niri
    ];
  };
}
