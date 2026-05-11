{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.server.nix
    ./../../modules/services/docker.nix
    ./../../modules/services/home-assistant.nix
    ./../../modules/services/monitoring.nix
    ./../../modules/services/smart-monitoring.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/nfs.nix
    ./../../modules/services/hd-idle.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services = {
    vnstat.enable = true;
    smartd = {
      enable = true;
      autodetect = true;
    };
    zfs = {
      autoScrub.enable = true;
      autoScrub.interval = "weekly";
      trim.enable = true;
    };
  };

  networking = {
    hostName = "flora";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        80
        443
        25565
        25567
        5201
      ];
      allowedUDPPorts = [
        5201
      ];
    };
  };

  # services.xserver.videoDrivers = [ "nvidia" ]; # --> put this in roles/nvidia.nix
  # liv.nvidia.enable = true;

  environment.systemPackages = [
    pkgs.kitty
    pkgs.foot
  ];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.11"; # Did you read the comment?
}
