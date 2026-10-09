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
    ./../../modules/services/ivpn.nix
    # ./../../modules/services/automount.nix
    # ./../../modules/home/webapps.nix
    ./../../modules/services/keyd.nix
    inputs.nixos-hardware.nixosModules.chuwi-minibook-x
  ];

  liv = {
    laptop.enable = true;
    gui.enable = true;
    gnome.enable = true;
    desktop.enable = false;
    creative.enable = false;
    amdgpu.enable = false;
  };

  environment.systemPackages = [
    pkgs.firefox
    pkgs.thunar
  ];

  hardware.intel-gpu-tools.enable = true;

  systemd.services."minibook-base-accelerometer.service" = {
    description = "enable (2nd) base accelerometer for chuwi minibook x";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.type = "oneshot";
    script = ''
      echo mxc4005 0x15 > /sys/bus/i2c/devices/i2c-0/new_device
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "primrose"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.sensor.iio.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}
