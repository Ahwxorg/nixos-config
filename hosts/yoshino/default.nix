{ inputs, pkgs, config, lib, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    # ./../../modules/home/nfs.nix
    ./../../modules/core/virtualization.nix
  ];
  
  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  liv = {
    desktop.enable = true;
    creative.enable = true;
  };

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
