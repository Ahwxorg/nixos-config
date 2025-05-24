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
  cfg = config.liv.router;
in
{
  options.liv.router = {
    enable = mkEnableOption "Enable router";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pkgs.kitty.terminfo
      powertop
      bind
    ];

    services = {
      thermald.enable = true;
      vnstat.enable = true;
      # cpupower-gui.enable = true;
      # power-profiles-daemon.enable = true;

      # auto-cpufreq = {
      #   enable = true;
      #   settings = {
      #     battery = {
      #       governor = "powersave";
      #       turbo = "auto";
      #     };
      #     charger = {
      #       governor = "performance";
      #       turbo = "auto";
      #     };
      #   };
      # };
    };
  };
}
