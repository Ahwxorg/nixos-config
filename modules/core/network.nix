{ pkgs, lib, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.macAddress = "stable-ssid";
    };
    nameservers = [ "9.9.9.9" ];
    firewall = {
      enable = true;
    };
  };
  services = {
    avahi.enable = lib.mkDefault false;
  };
}
