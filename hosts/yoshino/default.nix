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
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
        v4l2loopback
      ]
      ++ [pkgs.cpupower-gui];
    };
}
