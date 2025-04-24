{ lib, ... }:
with lib;
let
  cfg = config.liv.gui;
in
{
  config = mkIf cfg.enable {
    services = {
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      dbus.enable = true;
    };
  };
}
