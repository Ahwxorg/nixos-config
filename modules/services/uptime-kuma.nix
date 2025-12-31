{ config, ... }:
{
  services = {
    uptime-kuma = {
      enable = true;
      settings.PORT = "4800";
    };
    #anubis.instances.uptime-kuma = {
    #  settings = {
    #    TARGET = "http://localhost:4800";
    #    BIND = "/run/anubis/anubis-uptime-kuma/anubis.sock";
    #    METRICS_BIND = "/run/anubis/anubis-uptime-kuma/anubis.sock";
    #  };
    #};
    nginx.virtualHosts."uptime.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        # proxyPass = "http://unix:${toString config.services.anubis.instances.uptime-kuma.settings.BIND}";
        proxyPass = "http://localhost:4800";
        proxyWebsockets = true;
      };
    };
  };
}
