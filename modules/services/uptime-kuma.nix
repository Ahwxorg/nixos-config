{ config, ... }:
{
  services = {
    uptime-kuma = {
      enable = true;
      settings.PORT = "4800";
    };
    anubis.instances.uptime-kuma = {
      settings = {
        TARGET = "http://localhost:4800";
        BIND = ":4801";
        BIND_NETWORK = "tcp";
      };
    };
    nginx.virtualHosts."uptime.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost${toString config.services.anubis.instances.uptime-kuma.settings.BIND}";
        proxyWebsockets = true;
      };
    };
  };
}
