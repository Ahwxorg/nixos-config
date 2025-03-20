{ pkgs, config, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.server.nix
  ];

  networking.hostName = "dandelion";

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
    "olm-3.2.16"
  ];

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    pkgs.kitty.terminfo
  ];

  boot = {
    loader.systemd-boot = {
      enable = true;
      canTouchEfiVariables = true;
    };
  };
}
