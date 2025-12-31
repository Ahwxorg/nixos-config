{ config, ... }:
let
  target = "http://localhost:8081";
in
{
  services = {
    #anubis.instances.binternet = {
    #  settings = {
    #    TARGET = target;
    #    BIND = "/run/anubis/anubis-binternet/anubis.sock";
    #    METRICS_BIND = "/run/anubis/anubis-binternet/anubis.sock";
    #  };
    #};
    nginx.virtualHosts."curate.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        # proxyPass = "http://unix:${toString config.services.anubis.instances.binternet.settings.BIND}";
        proxyPass = target;
        proxyWebsockets = true;
      };
    };
  };
}
