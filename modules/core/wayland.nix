{ username, pkgs, ... }:
{
  services = {
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
