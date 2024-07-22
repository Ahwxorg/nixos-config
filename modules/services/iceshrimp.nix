{ config, pkgs, iceshrimp, ... }:
{

  services = {
    postgresql = {
      enable = true;
      initialScript = pkgs.writeText "synapse-init.sql" ''
        CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
        CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
          TEMPLATE template0
          LC_COLLATE = "C"
          LC_CTYPE = "C";
      '';
    };


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
