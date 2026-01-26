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
    # imports = [ ../modules/core/displaylink.nix ];

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

      udev.extraRules = ''
        # Switch to power-save profile when on battery
        SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver", RUN+="/bin/sh -c 'echo 30 | tee /sys/class/backlight/amdgpu_bl1/brightness'"
        # Switch to balanced profile when plugged in
        SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced", RUN+="/bin/sh -c 'cat /sys/class/backlight/amdgpu_bl1/max_brightness > /sys/class/backlight/amdgpu_bl1/brightness'"
      '';

      upower = {
        enable = true;
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 5;
        criticalPowerAction = "Hibernate";
      };
      #auto-cpufreq = {
      #  enable = true;
      #  settings = {
      #    battery = {
      #      governor = "powersave";
      #      turbo = "never";
      #      energy_performance_preference = "balance_power";
      #    };
      #    charger = {
      #      governor = "performance";
      #      turbo = "auto";
      #      energy_performance_preference = "performance";
      #    };
      #  };
      #};
    };
    # powerManagement.powertop.enable = false; # somehow figure out how to let this not apply to specific USB devices, as they will auto suspend and that is annoying.
  };
}
