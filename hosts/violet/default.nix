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
    # ./backups.nix # disable for now, test first.
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

  services = {
    smartd = {
      enable = lib.mkForce false;
      autodetect = lib.mkForce false;
    };
    xserver.videoDrivers = [ "nvidia" ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      25565
    ];
  };

  liv.nvidia.enable = true;

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
