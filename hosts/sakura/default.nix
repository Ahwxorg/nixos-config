{ inputs, pkgs, config, lib, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/core/virtualization.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];
  
  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  environment.systemPackages = with pkgs; [
    fwupd                                           # Update firmware for Framework Laptop 13
  ];

  liv = { 
    laptop.enable = true;
    desktop.enable = true;
    creative.enable = true;
  };

  services.hardware.bolt.enable = true;

  hardware.framework.amd-7040.preventWakeOnAC = true;
  networking.hostName = "sakura";

  boot = {
    kernelParams = [ "mem_sleep_default=deep" "acpi_osi=\"!Windows 2020\"" ];
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
}
