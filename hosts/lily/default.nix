{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./variables.nix
    ./../../modules/core/default.server.nix
  ];

  networking.hostName = "lily";

  liv.server.enable = true;

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    kitty.terminfo
    zfs
  ];

  boot = {
    supportedFilesystems = [ "zfs" ];
  };

  networking.hostId = "8ddb2a9b";

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # boot.zfs.extraPools = [ "terrabite" ];

  # fileSystems."/terrabite/main" = {
  #   device = "terrabite/main";
  #   fsType = "zfs";
  # };
}
