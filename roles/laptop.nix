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
  cfg = config.liv.laptop;
in
{
  options.liv.laptop = {
    enable = mkEnableOption "Enable laptop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cifs-utils
      powertop
    ];
    home-manager = {
      users.${username} = {
        home.packages = with pkgs; [
          acpi
          brightnessctl
        ];
      };
    };

    # DisplayLink
    services.xserver.videoDrivers = [
      "displaylink"
      "modesetting"
    ];
    systemd.services.dlm.wantedBy = [ "multi-user.target" ];

    networking.networkmanager.enable = true;

    boot = {
      kernelModules = [ "acpi_call" ];
      extraModulePackages = with config.boot.kernelPackages; [
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
    powerManagement.powertop.enable = false; # somehow figure out how to let this not apply to specific USB devices, as they will auto suspend and that is annoying.
  };
}
