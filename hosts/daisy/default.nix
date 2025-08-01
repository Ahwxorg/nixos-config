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
    # ./../../modules/services/violet.nix
  ];

  networking = {
    hostName = "daisy";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        # 80
        # 443
        # 25565
        9123
      ];
    };
  };

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    pkgs.kitty.terminfo
  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sdb";
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
