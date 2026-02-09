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
    environment.systemPackages = with pkgs; [ cifs-utils ];
    home-manager = {
      users.${username} = {
        home.packages = with pkgs; [
          # Home packages
          swaylock
          lm_sensors
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
