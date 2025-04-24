{
  config,
  ...
}:
let
  domain = "statistics.liv.town";
in
{
  services = {
    nginx.virtualHosts.${domain} = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.plausible.server.port}";
    };

    plausible = {
      enable = true;

      adminUser = {
        # activate is used to skip the email verification of the admin-user that's
        # automatically created by plausible. This is only supported if
        # postgresql is configured by the module. This is done by default, but
        # can be turned off with services.plausible.database.postgres.setup.
        activate = true;
        email = "${config.liv.email}";
        # passwordFile = config.age.secrets.plausibleAdminPassword.path;
      };

      server = {
        baseUrl = "https://${domain}";
        # secretKeybaseFile = config.age.secrets.plausibleSecretKeybase.path;
      };
    };
  };
}
