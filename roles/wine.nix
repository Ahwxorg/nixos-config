{ lib, pkgs, config, username, home-manager, ... }:
with lib;
let
  cfg = config.liv.wine;
in {
  options.liv.wine = {
    enable = mkEnableOption "Enable wine";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      wineWowPackages.waylandFull
      winetricks
      mono5
      mono
    ];
  };
}
