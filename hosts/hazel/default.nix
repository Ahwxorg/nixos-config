{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./../../modules/core/default.server.nix
    # ./../../modules/services/hazel.nix
  ];

  networking.hostName = "hazel";

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];

  time.timeZone = lib.mkForce "Europe/Paris";

  environment.systemPackages = with pkgs; [
    kitty.terminfo
  ];

  services = {
    smartd = {
      enable = true;
      autodetect = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      9123
    ];
  };

  boot = {
    loader.grub = {
      enable = true;
      # device = "/dev/sda";
    };
  };
}
