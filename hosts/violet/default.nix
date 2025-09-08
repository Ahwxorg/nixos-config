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
    kitty.terminfo
    cifs-utils
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
      5201
    ];
    allowedUDPPorts = [
      5201
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

  fileSystems."/mnt/nfs/violet" = {
    device = "//172.16.10.130/spinners/violet"; # not ideal, should get the static IP from dandelion from a config attribute but whatever...
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "credentials=${config.sops.secrets.smbLoginDetails.path}"
    ];
  };
}
