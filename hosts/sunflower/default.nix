{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./variables.nix
    ./../../modules/core/default.server.nix
    ./../../modules/services/sunflower.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  liv.server.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];

  networking = {
    hostName = "sunflower";
    firewall = {
      allowedTCPPorts = [
        5201
      ];
      allowedUDPPorts = [
        5201
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    kitty.terminfo
    zfs
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sdb";
        useOSProber = true;
      };
    };
    supportedFilesystems = [ "zfs" ];
  };

  networking.hostId = "6b57f171";

  #services.zfs = {
  #  autoScrub.enable = true;
  #  autoScrub.interval = "weekly";
  #  trim.enable = true;
  #};

  #boot.zfs.extraPools = [
  #  "spinners"
  #];

  # fileSystems = {
  #   "/spinners/rootvol" = {
  #     device = "spinners/rootvol";
  #     fsType = "zfs";
  #   };
  #   "/spinners/ahwx" = {
  #     device = "spinners/ahwx";
  #     fsType = "zfs";
  #   };
  #   "/spinners/violet" = {
  #     device = "spinners/violet";
  #     fsType = "zfs";
  #   };
  # };
}
