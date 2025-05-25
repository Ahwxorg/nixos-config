{ config, ... }:
{
  services = {
    anubis.instances.binternet = {
      settings = {
        TARGET = "http://localhost:8081";
        BIND = ":8082";
        BIND_NETWORK = "tcp";
      };
    };
    nginx.virtualHosts."curate.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost${toString config.services.anubis.instances.binternet.settings.BIND}";
        proxyWebsockets = true;
      };
    };
  };
}
