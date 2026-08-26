{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../../modules/core
    ./hardware-configuration.nix
    ./../../modules/services/tailscale.nix
    # ../../modules/core/sshfs.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/mullvad.nix
    # ./../../modules/services/automount.nix
    # ./../../modules/home/webapps.nix
    ./../../modules/services/keyd.nix
  ];

  liv = {
    laptop.enable = true;
    gui.enable = true;
    desktop.enable = false;
    creative.enable = false;
    amdgpu.enable = false;
  };

  environment.systemPackages = [
    pkgs.obs-studio
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "primrose"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.sensor.iio.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}
