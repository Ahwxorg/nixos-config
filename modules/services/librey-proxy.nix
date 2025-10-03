{ config, ... }:
{
  services = {
    anubis.instances.librey = {
      settings = {
        TARGET = "http://localhost:8078";
        BIND = ":8079";
        BIND_NETWORK = "tcp";
      };
    };
    nginx.virtualHosts."search.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost${toString config.services.anubis.instances.librey.settings.BIND}";
        proxyWebsockets = true;
      };
    };
  };
}
