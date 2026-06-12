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
  cfg = config.liv.desktop;
in
{
  options.liv.desktop = {
    enable = mkEnableOption "Enable desktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.cifs-utils ];
    home-manager = {
      users.${username} = {
        home.packages = [
          # Home packages
          pkgs.swaylock
          pkgs.lm_sensors
        ];
      };
    };

    networking.networkmanager.enable = true;

    boot = {
      kernelModules = [ "acpi_call" ];
      extraModulePackages = with config.boot.kernelPackages; [
        acpi_call
      ];
    };
    services = {
      thermald.enable = true;
      hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = "intel";
        server = {
          port = 6742;
          # autoStart = true;
        };
      };
    };
  };
}
