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
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    environment.systemPackages = [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-vaapi # optional AMD hardware acceleration
          obs-gstreamer
          obs-vkcapture
        ];
      })
    ];
    home-manager = {
      users.${username} = {
        home.packages = with pkgs; [
          gimp
          darktable
          audacity
          orca-slicer
          # kdePackages.kdenlive
          # freecad
        ];
      };
    };
  };
}
