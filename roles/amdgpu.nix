{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.liv.amdgpu;
in
{
  options.liv.amdgpu = {
    enable = mkEnableOption "Enable amdgpu drivers";
  };

  config = mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          mesa
          libva
          libvdpau-va-gl
          vulkan-loader
          vulkan-validation-layers
          amdvlk
          mesa.opencl
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk # Install amdvlk for 32 bit applications as well
        ];
      };
      enableRedistributableFirmware = true;
    };

    boot.initrd.kernelModules = [ "amdgpu" ];

    environment.systemPackages = with pkgs; [
      amdvlk
    ];
  };
}
