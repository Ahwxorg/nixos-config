{ pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    nameservers = [ "9.9.9.9" ];
    firewall = {
      enable = true;
    };
  };
  services = {
    avahi.enable = false;
  };
}
