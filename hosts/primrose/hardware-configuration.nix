{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
#let
#  vbtFirmware = pkgs.runCommand "firmware-vbt-patched" { } ''
#    mkdir -p $out/lib/firmware
#    cp "${./vbt_patched.bin}" $out/lib/firmware/vbt
#  '';
#in
{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/42011953-83d8-4b14-9c7e-555073d1fff0";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D7BA-B251";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/78f39c14-d6d8-4d19-a81f-ed77ea5c1f9a"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  #  hardware.firmware = [ vbtFirmware ];
  #  boot.initrd.extraFirmwarePaths = [ "vbt" ];
  #  boot.kernelParams = [
  #    "quiet"
  #    "i915.vbt_firmware=vbt"
  #  ];
}
