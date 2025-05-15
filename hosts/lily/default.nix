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
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
  };

  networking.hostId = "8wfk1d8a";

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  # boot.zfs.extraPools = [ "terrabite" ];

  # fileSystems."/terrabite/main" = {
  #   device = "terrabite/main";
  #   fsType = "zfs";
  # };
}
