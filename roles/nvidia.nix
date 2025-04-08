{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.liv.nvidia;
in
{
  options.liv.nvidia = {
    enable = mkEnableOption "Enable NVIDIA drivers";
  };

  config = mkIf cfg.enable {
    hardware = {
      enableRedistributableFirmware = true;
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          # amdvlk
        ];
        # For 32 bit applications as well
        extraPackages32 = with pkgs; [
          # driversi686Linux.amdvlk
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      # amdvlk
    ];
  };
}
