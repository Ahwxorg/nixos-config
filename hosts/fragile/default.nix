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
    # ./apple-silicon-support
    ./../../modules/services/tailscale.nix
    # ../../modules/core/sshfs.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/mullvad.nix
    # ./../../modules/services/automount.nix
    # ./../../modules/home/webapps.nix
    ./../../modules/services/keyd.nix
  ];

  hardware.asahi = {
    enable = true;
    peripheralFirmwareDirectory = ./firmware;
  };

  environment = {
    systemPackages = [
      pkgs.asahi-bless
      pkgs.monero-gui
      pkgs.btrfs-progs
      pkgs.apfs-fuse
      pkgs.neovim
      pkgs.wget
      pkgs.acpi
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
    # displayManager.ly.enable = true;
    vnstat.enable = true;
    pcscd.enable = lib.mkForce true;
    # hardware.bolt.enable = true; # enable once Thunderbolt is supported
  };

  # swapDevices = [
  #   {
  #     device = "/swapfile";
  #     size = 32 * 1024;
  #     options = [ "discard" ]; # enabling TRIM
  #   }
  # ];

  # zramSwap.enable = true;

  boot = {
    kernelParams = [
      "appledrm.show_notch=1"
      "hid_apple.swap_fn_leftctrl=1"
      "hid_apple.swap_opt_cmd=1"
      "zswap.enabled=1" # enables zswap
      "zswap.compressor=lz4" # compression algorithm
      "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
      "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
    ];
    initrd.systemd.enable = true; # required by lz4 in zram
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernel.sysctl."vm.mmap_rnd_bits" = 18;
    kernelPatches =
      # [
      #   {
      #     name = "localversion-config";
      #     patch = null;
      #     extraConfig = ''
      #       LOCALVERSION -according-to-all-known-laws-of-aviation-there-is-no-way-a
      #     '';
      #   }
      # ]
      # ++
      map (x: {
        name = baseNameOf x;
        patch = x;
      }) (lib.filesystem.listFilesRecursive (./kernelPatches));
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
