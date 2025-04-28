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
  };
}
