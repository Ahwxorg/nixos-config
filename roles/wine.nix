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
  cfg = config.liv.wine;
in
{
  options.liv.wine = {
    enable = mkEnableOption "Enable wine";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wineWowPackages.stable
      pkgs.wineWowPackages.waylandFull
      pkgs.winetricks
      pkgs.mono5
      pkgs.mono
    ];
  };
}
