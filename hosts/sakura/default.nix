{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/core/virtualization.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  liv = {
    laptop.enable = true;
    desktop.enable = false;
    creative.enable = true;
    amdgpu.enable = true;
    gui.enable = true;
  };

  environment.systemPackages = with pkgs; [ fwupd ];
  hardware.framework = {
    amd-7040.preventWakeOnAC = true;
    laptop13.audioEnhancement.enable = true;
  };
  services.hardware.bolt.enable = true;

  networking.hostName = "sakura";

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };
  boot = {
    plymouth.enable = true;
    kernelParams = [
      "mem_sleep_default=deep"
      "acpi_osi=\"!Windows 2020\""
    ];
    kernelModules = [ "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [ pkgs.cpupower-gui ];
  };
}
