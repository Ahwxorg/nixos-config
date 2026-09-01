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
    # ./apple-silicon-support
    ./../../modules/services/tailscale.nix
    # ../../modules/core/sshfs.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/ivpn.nix
    # ./../../modules/services/automount.nix
    # ./../../modules/home/webapps.nix
    ./../../modules/services/keyd.nix
    ./steam.nix
    ./../../modules/core/displaylink.nix
  ];

  hardware.asahi = {
    enable = true;
    peripheralFirmwareDirectory = ./firmware;
  };

  #environment.variables = {
  #  WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1";
  #};

  environment = {
    systemPackages = [
      pkgs.asahi-bless
      pkgs.monero-gui
      pkgs.btrfs-progs
      pkgs.apfs-fuse
      pkgs.remmina
      pkgs.firefox
    ];
  };

  liv = {
    laptop.enable = true;
    creative.enable = true;
    gui.enable = true;
    gnome.enable = true;
  };

  networking = {
    hostName = "fragile";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  services = {
    vnstat.enable = true;
    pcscd.enable = lib.mkForce true;
    # hardware.bolt.enable = true; # enable once Thunderbolt is supported
  };

  boot = {
    kernelParams = [
      "appledrm.show_notch=1"
      "hid_apple.swap_fn_leftctrl=1"
      "hid_apple.swap_opt_cmd=1"
    ];
    initrd.systemd.enable = true; # required by lz4 in zram
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernel.sysctl."vm.mmap_rnd_bits" = 18;
    # kernelPatches = map (x: {
    #   name = baseNameOf x;
    #   patch = x;
    # }) (lib.filesystem.listFilesRecursive (./kernelPatches));
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
