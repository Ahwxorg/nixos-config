{ pkgs, config, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./variables.nix
    ./../../modules/core/default.server.nix
    ./../../modules/services/dandelion.nix
  ];

  networking.hostName = "dandelion";

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];

  time.timeZone = "Europe/Amsterdam";

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

  boot.zfs.extraPools = [ "terrabite" ];

  # fileSystems."/terrabite/main" = {
  #   device = "terrabite/main";
  #   fsType = "zfs";
  # };
}
