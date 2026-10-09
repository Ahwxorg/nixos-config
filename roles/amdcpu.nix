{ lib, config, ... }:
{
  # enable amd pstate driver, supports Epyc 7002 and later, Ryzen 3000 and later
  boot.kernelParams = [ "amd_pstate=active" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
