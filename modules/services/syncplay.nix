{ config, ... }:
{
  services.syncplay = {
    enable = true;
    passwordFile = config.sops.secrets.syncplay.path;
  };
  networking.firewall.allowedTCPPorts = [ 8999 ];
}
