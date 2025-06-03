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
  cfg = config.liv.creative;
in
{
  options.liv.creative = {
    enable = mkEnableOption "Enable creative workflow";
  };

  config = mkIf cfg.enable {
    home-manager = {
      users.${username} = {
        home.packages = with pkgs; [
          gimp
          darktable
          audacity
          obs-studio
          kdePackages.kdenlive
          orca-slicer
          freecad
        ];
      };
    };
  };
}
