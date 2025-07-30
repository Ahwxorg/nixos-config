{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      SIGNUPS_ALLOWED = false;
      ENABLE_WEBSOCKET = true;
      SENDS_ALLOWED = true;
      INVITATIONS_ENABLED = true;
      EMERGENCY_ACCESS_ALLOWED = true;
      EMAIL_ACCESS_ALLOWED = true;
      DOMAIN = "https://passwords.liv.town";
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8003;
    };
  };
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "passwords.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}/";
          proxyWebsockets = true;
        };
      };
    };
  };
}
