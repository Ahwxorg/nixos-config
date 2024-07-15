{ config, pkgs, iceshrimp, ... }:
{

  services = {
    # redis.servers.iceshrimp = {
    #   enable = true;
    #   port = 6380;
    #   bind = "0.0.0.0";
    #   settings.protected-mode = "no";
    # };

    iceshrimp = {
      enable = true;
      settings = { 
        url = "https://fedi.liv.town"; # The domain your Iceshrimp UI will be served on.
        settings.db.host = "/run/postgresql"; # omitting this setting causes some configurations to fail
      };
      dbPasswordFile = /var/iceshrimp/dbPasswordFile;
      secretConfig = /var/iceshrimp/secretConfig.yml;
    };
  };
}
