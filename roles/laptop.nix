{ config, pkgs, lib, ... }:
{
  options = {
    liv.laptop = lib.mkOption {
      default = false;
      type = lib.types.boolean;
      description = ''
        Enable this if the host is a laptop, to enable power management, extra packages, kernel modules, etc.
      '';
    };

  config = lib.mkIf config.liv.laptop {
    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
      acpi
      brightnessctl
      cpupower-gui
      powertop
    ];
    auto-cpufreq = {
      enable = false;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    boot = {
      kernelModules = ["acpi_call"];
      extraModulePackages = with config.boot.kernelPackages;
        [
          acpi_call
          cpupower
        ]
        ++ [pkgs.cpupower-gui];
      };
    };
  };
}
