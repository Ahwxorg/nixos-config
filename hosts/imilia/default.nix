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
    ./../../modules/services/tailscale.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/smart-monitoring.nix
  ];

  # install some system-utilities; set hosts to be editable by the user.
  environment = {
    systemPackages = with pkgs; [
      fwupd
    ];
    etc.hosts.mode = "0700";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 64 * 1024;
    }
  ];

  liv = {
    laptop.enable = true;
    desktop.enable = false;
    creative.enable = true;
    amdgpu.enable = false;
    nvidia.enable = true;
    gui.enable = true;
  };

  services = {
    vnstat.enable = true;
    hardware.bolt.enable = true;
  };

  # Disable light sensors and accelerometers as they are not used and consume extra battery
  hardware.sensor.iio.enable = lib.mkForce false;

  networking = {
    hostName = "imilia";
    # networkmanager.ethernet.macAddress = "13:37:6a:8a:ed:a4";
  };

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitch = "ignore";
  boot = {
    kernelModules = [ "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # systemd-boot.configurationLimit = 10;
    };
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
        v4l2loopback
      ]
      ++ [ pkgs.cpupower-gui ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
