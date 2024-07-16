{ config, pkgs, iceshrimp, ... }:
{

  services = {
    # postgresql = {
    #   enable = true;
    #   initialScript = pkgs.writeText "iceshrimp.sql" ''
    #     CREATE ROLE "iceshrimp" WITH LOGIN PASSWORD 'uph2reeloo3aeDae4muc';
    #     CREATE DATABASE "iceshrimp" WITH OWNER "iceshrimp"
    #       TEMPLATE template0
    #       LC_COLLATE = "C"
    #       LC_CTYPE = "C";
    #   '';
    # };


    iceshrimp = {
      enable = true;
      settings = { 
        configureNginx = true;
        createDb = true;
        url = "https://fedi.liv.town"; # The domain your Iceshrimp UI will be served on.
        # settings.db.host = "/run/postgresql"; # omitting this setting causes some configurations to fail
      };
      dbPasswordFile = /var/iceshrimp/dbPasswordFile;
      secretConfig = /var/iceshrimp/secretConfig.yml;
    };
  };
}
