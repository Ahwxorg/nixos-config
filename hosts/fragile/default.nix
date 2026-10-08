{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/core
    ./hardware-configuration.nix
    inputs.apple-silicon-support.nixosModules.apple-silicon-support
    inputs.steam-asahi.nixosModules.default
    ./../../modules/services/tailscale.nix
    # ../../modules/core/sshfs.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/ivpn.nix
    # ./../../modules/services/automount.nix
    ./../../modules/services/keyd.nix
    ./steam.nix
    ./../../modules/core/displaylink.nix
  ];

  environment = {
    systemPackages = [
      pkgs.asahi-bless
      pkgs.monero-gui
      pkgs.btrfs-progs
      pkgs.apfs-fuse
      pkgs.remmina
      pkgs.firefox
      pkgs.thunar
      pkgs.prismlauncher
    ];
  };

  liv = {
    laptop.enable = true;
    creative.enable = true;
    gui.enable = true;
    gnome.enable = true;
  };

  services = {
    # hardware.bolt.enable = true; # enable once Thunderbolt is supported
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
