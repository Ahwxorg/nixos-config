{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/services/tailscale.nix
  ];

  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  liv.laptop.enable = true;
  liv.gui.enable = true;

  # Bootloader stuff
  boot = {
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "splash"
    ];
    loader.grub = {
      enable = lib.mkForce true;
      device = lib.mkForce "/dev/sda";
      enableCryptodisk = lib.mkForce true;
      useOSProber = lib.mkForce true;
    };
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
    initrd.luks.devices."luks-729500c5-557b-45c8-ab3f-5c365db28284".keyFile =
      lib.mkForce "/crypto_keyfile.bin";
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [ pkgs.cpupower-gui ];
  };

  networking.hostName = "ichiyo";
}
