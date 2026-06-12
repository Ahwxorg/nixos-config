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
  cfg = config.liv.gnome;
in
{
  options.liv.gnome = {
    enable = mkEnableOption "Enable GNOME workflow";
  };

  config = mkIf cfg.enable {
    security.pam.services.gdm.enableGnomeKeyring = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.gnome.core-apps.enable = false;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
    ];
  };
}
