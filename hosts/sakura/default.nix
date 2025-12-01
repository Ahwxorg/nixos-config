{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  mac_ethernet = "13:37:00:00:00:01";
in
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/core/virtualization.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/smart-monitoring.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ./../../modules/security/dnscrypt.nix
    ./../../modules/security/syslogd.nix
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
    laptop13.audioEnhancement.enable = true;
  };

  # Disable light sensors and accelerometers as they are not used and consume extra battery
  hardware.sensor.iio.enable = lib.mkForce false;

  networking = {
    hostName = "sakura";
    # networkmanager.ethernet.macAddress = "13:37:6a:8a:ed:a4";
  };

  environment.etc."NetworkManager/conf.d/20-ethernet-mac-address.conf".text = ''
    [connection.20-ethernet-mac-addr]
    match-device=type:ethernet
    ethernet.cloned-mac-address=${mac_ethernet}

    [.config]
    enable=nm-version-min:1.45
  '';

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
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
  boot = {
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
