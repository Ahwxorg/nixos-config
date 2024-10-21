{ inputs, pkgs, config, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];
  
  liv.laptop.enable = true;

  hardware.framework.amd-7040.preventWakeOnAC = true;
  networking.hostName = "sakura";

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
}
