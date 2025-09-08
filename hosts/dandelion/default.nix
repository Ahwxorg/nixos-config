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
    ./../../modules/services/dandelion.nix
  ];

  users.users.liv.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLdcB5JFWx6OK2BAr8J0wPHNhr2VP2/Ci6fv3a+DPfo liv@violet" # allow violet to log in over ssh to do back ups
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDi8gt51xGRzLSqaNr1LKSdrJ0VHps8U8FME71YCrs6K liv@posy" # allow posy to log in over ssh to mount music folder
  ];

  liv.server.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];

  time.timeZone = "Europe/Amsterdam";

  networking = {
    hostName = "dandelion";
    firewall = {
      allowedTCPPorts = [
        5201
      ];
      allowedUDPPorts = [
        5201
      ];
      interfaces."ens4s1".allowedTCPPorts = [
        # allow everything for local link
        {
          from = 1;
          to = 65354;
        }
      ];
      interfaces."ens4s1".allowedUDPPorts = [
        # allow everything for local link
        {
          from = 1;
          to = 65354;
        }
      ];
    };
  };

  systemd.network.networks."99-local" = {
    matchConfig.name = "ens4s1";
    address = [
      "192.168.1.100/24"
    ];
    routes = [
      {
        Gateway = "172.16.10.1";
        GatewayOnLink = false;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    kitty.terminfo
    zfs
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
  };

  networking.hostId = "8a6b2565";

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  boot.zfs.extraPools = [
    "spinners"
  ];

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
