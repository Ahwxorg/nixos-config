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
    ./../../modules/services/mullvad.nix
    ./../../modules/home/steam.nix
    ./../../modules/services/ollama.nix
    # ./../../modules/services/automount.nix
  ];

  # install some system-utilities; set hosts to be editable by the user.
  environment = {
    systemPackages = [
      pkgs.fwupd
      pkgs.fw-ectool
      pkgs.monero-gui
      pkgs.remmina
      pkgs.spotify
    ];
  };

  liv = {
    laptop.enable = true;
    desktop.enable = false;
    creative.enable = true;
    # amdgpu.enable = true;
    gui.enable = true;
    wine.enable = true;
  };

  services = {
    vnstat.enable = true;
    hardware.bolt.enable = true;
  };

  networking = {
    hostName = "sakura";
  };

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';
  boot = {
    kernelParams = [
      "mem_sleep_default=deep"
    ];
    plymouth.enable = false;
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
