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
    ./../../modules/services/home-assistant.nix
    ./../../modules/services/monitoring.nix
    ./../../modules/services/smart-monitoring.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/nfs.nix
    ./../../modules/services/hd-idle.nix

    ./../../modules/services/invidious.nix
    ./../../modules/services/binternet-proxy.nix
    ./../../modules/services/email.nix
    ./../../modules/services/forgejo.nix
    ./../../modules/services/gokapi.nix
    ./../../modules/services/immich-proxy.nix
    ./../../modules/services/matrix/default.nix
    ./../../modules/services/mumble.nix
    ./../../modules/services/ntfy.nix
    ./../../modules/services/nginx.nix
    ./../../modules/services/prosody.nix
    ./../../modules/services/pollaris-proxy.nix
    ./../../modules/services/radicale.nix
    ./../../modules/services/sharkey-proxy.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/uptime-kuma.nix
    ./../../modules/services/vaultwarden.nix
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

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

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
