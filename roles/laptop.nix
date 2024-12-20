{ lib, pkgs, config, username, home-manager, ... }:
with lib;
let
  cfg = config.liv.laptop;
in {
  options.liv.laptop = {
    enable = mkEnableOption "Enable laptop";
  };

  config = mkIf cfg.enable {
    home-manager = {
      users.${username} = {
        home.packages = with pkgs; [
          acpi
          brightnessctl
        ];
      };
    };

    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
      # powertop
    ];
    boot = {
      kernelModules = ["acpi_call"];
      extraModulePackages = with config.boot.kernelPackages;
        [
          acpi_call
        ];
      };
    services = {    
      thermald.enable = true;
      power-profiles-daemon.enable = true;
 
      upower = {
        enable = true;
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 5;
        criticalPowerAction = "Hibernate";
      };
    };
    # powerManagement.powertop.enable = true;
  };
}
