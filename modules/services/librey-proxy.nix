{ config, ... }:
let
  target = "http://localhost:8078";
in
{
  services = {
    #anubis.instances.librey = {
    #  settings = {
    #    TARGET = target;
    #    BIND = "/run/anubis/anubis-librey/anubis.sock";
    #    METRICS_BIND = "/run/anubis/anubis-librey/anubis.sock";
    #  };
    #};
    nginx.virtualHosts."search.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        # proxyPass = "http://unix:${toString config.services.anubis.instances.librey.settings.BIND}";
        proxyPass = target;
        proxyWebsockets = true;
      };
    };
  };
}
