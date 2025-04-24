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
  cfg = config.liv.server;
in
{
  options.liv.server = {
    enable = mkEnableOption "Enable server";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pkgs.kitty.terminfo
      powertop
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
      netdata = {
        enable = true;
        package = pkgs.netdata.override {
          withCloudUi = true;
        };
      };
    };
  };
}
