{ inputs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  hardware.framework.amd-7040.preventWakeOnAC = true;
  networking.hostName = "sakura";

  liv.laptop = true;

  services = {    
    thermald.enable = true;
    cpupower-gui.enable = true;
    # power-profiles-daemon.enable = true;
 
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };
  };
}
