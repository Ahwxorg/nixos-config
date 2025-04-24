{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.server.nix
    ./../../modules/services/violet.nix
  ];

  networking.hostName = "violet";

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    pkgs.kitty.terminfo
  ];

  services.smartd = {
    enable = lib.mkForce false;
    autodetect = lib.mkForce false;
  };

  liv.nvidia.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
    kernelModules = [ "acpi_call" ];
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [ pkgs.cpupower-gui ];
  };
}
