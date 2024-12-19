{ pkgs, ... }:
{  
  hardware = {
    graphics = {
      enable = true;
      # driSupport = true; # Has no effect anymore, as of 2024-06-21
      # driSupport32Bit = true;
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
}
