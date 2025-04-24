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
      nvidia.open = false; # Set to false/true for proprietary/open drivers
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          # amdvlk would be the package that would be required for AMD on desktop, since none of the hosts use NVIDIA as a desktop GPU, this is open and uncertain.
        ];
        # For 32 bit applications as well
        extraPackages32 = with pkgs; [
          # driversi686Linux.amdvlk would be the package that would be required for AMD on desktop, since none of the hosts use NVIDIA as a desktop GPU, this is open and uncertain.
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      # amdvlk
    ];
  };
}
