{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.displaylink
    # pkgs.linuxPackages.evdi
  ];

  boot = {
    kernelModules = [ "evdi" ];
    initrd.kernelModules = [ "evdi" ];

    extraModulePackages = [
      config.boot.kernelPackages.evdi
    ];
  };

  services.udev.packages = [ pkgs.displaylink ];

  services.xserver.videoDrivers = [
    "displaylink"
    "modesetting"
  ];
  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}
