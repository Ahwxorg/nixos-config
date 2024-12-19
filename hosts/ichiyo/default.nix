{ lib, inputs, pkgs, config, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];
  
  powerManagement = {
    enable = true;
    # powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  liv.laptop.enable = true;

  # Bootloader stuff
  boot.loader.grub.enable = lib.mkForce true;
  boot.loader.grub.device = lib.mkForce "/dev/sda";
  boot.loader.grub.useOSProber = lib.mkForce true;
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.loader.grub.enableCryptodisk = lib.mkForce true;
  boot.initrd.luks.devices."luks-729500c5-557b-45c8-ab3f-5c365db28284".keyFile = lib.mkForce "/crypto_keyfile.bin";

  networking.hostName = "ichiyo";

  boot = {
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
}
