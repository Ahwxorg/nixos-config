{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/services/tailscale.nix
    ./../../modules/services/mpd.nix
  ];

  liv = {
    laptop.enable = true;
    gui.enable = true;
    desktop.enable = false;
    creative.enable = false;
    amdgpu.enable = false;
  };

  services = {
    vnstat.enable = true;
  };

  networking.hostName = "zinnia";

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  boot.initrd.luks.devices."luks-59aff546-c2c2-4697-a5f2-40a12f259f5a".device =
    "/dev/disk/by-uuid/59aff546-c2c2-4697-a5f2-40a12f259f5a";

  boot = {
    kernelParams = [
      "mem_sleep_default=deep"
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

  time.timeZone = "Europe/Amsterdam";
  nixpkgs.config.allowUnfree = true;
}
