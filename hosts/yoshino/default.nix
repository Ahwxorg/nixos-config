{ inputs, pkgs, config, lib, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/core/virtualization.nix
  ];
  
  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  liv.laptop.enable = false;

  networking = {
    hostName = "yoshino";
    networkmanager.enable = true;
  };

  boot = {
    kernelParams = [ ];
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
}
