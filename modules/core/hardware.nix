{ pkgs, ... }:
{  
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
}
