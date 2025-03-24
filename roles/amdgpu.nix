{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.liv.amdgpu;
in {
  options.liv.amdgpu = {
    enable = mkEnableOption "Enable amdgpu drivers";
  };

  config = mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
      };
      enableRedistributableFirmware = true;
      opengl = {
        extraPackages = with pkgs; [
          amdvlk
        ];
        # For 32 bit applications as well
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      amdvlk
    ];
  };
}
