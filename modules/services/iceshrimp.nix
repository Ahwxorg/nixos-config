{ ... }:
{
  services.iceshrimp = {
    enable = true;
    settings = { 
      url = "https://fedi.liv.town"; # The domain your Iceshrimp UI will be served on.
      settings.db.host = "/run/postgresql"; # omitting this setting causes some configurations to fail
    };
    dbPasswordFile = /var/iceshrimp/dbPasswordFile;
    secretConfig = /var/iceshrimp/secretConfig.yml;
  };
}
