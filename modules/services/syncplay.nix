{ config, ... }:
{
  services.syncplay = {
    enable = true;
    passwordFile = config.sops.secrets.syncplay.path;
  };
}
