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
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # install some system-utilities; set hosts to be editable by the user.
  environment = {
    systemPackages = with pkgs; [
      fwupd
      fw-ectool
    ];
    etc.hosts.mode = "0700";
  };

  liv = {
    laptop.enable = true;
    desktop.enable = false;
    creative.enable = true;
    amdgpu.enable = true;
    gui.enable = true;
  };

  services = {
    vnstat.enable = true;
    hardware.bolt.enable = true;
  };

  hardware.framework = {
    amd-7040.preventWakeOnAC = true;
    # laptop13.audioEnhancement.enable = true; # makes audio almost muted
  };

  # Disable light sensors and accelerometers as they are not used and consume extra battery
  hardware.sensor.iio.enable = lib.mkForce false;

  networking = {
    hostName = "sakura";
    # networkmanager.ethernet.macAddress = "13:37:6a:8a:ed:a4";
  };

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };
  # change battery led to blue on suspend to indicate device is in suspend mode
  systemd.services."suspend-led-set" = {
    description = "blue led for sleep";
    wantedBy = [ "suspend.target" ];
    before = [ "systemd-suspend.service" ];
    serviceConfig.type = "simple";
    script = ''
      ${pkgs.fw-ectool}/bin/ectool led battery blue
    '';
  };
  systemd.services."suspend-led-unset" = {
    description = "auto led after sleep";
    wantedBy = [ "suspend.target" ];
    after = [ "systemd-suspend.service" ];
    serviceConfig.type = "simple";
    script = ''
      ${pkgs.fw-ectool}/bin/ectool led battery auto
    '';
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';
  services.logind.lidSwitch = "suspend";
  boot = {
    # plymouth.enable = true; # is a module now
    kernelParams = [
      "mem_sleep_default=deep"
      "acpi_osi=\"!Windows 2020\"" # otherwise GPU does weird shit that makes the computer look like the RAM is broken
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
        v4l2loopback
      ]
      ++ [ pkgs.cpupower-gui ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
