{ config, ... }:
{
  services = {
    grafana = {
      enable = true;
      settings.server = {
        domain = "monitoring.liv.town";
        http_addr = "127.0.0.1";
        http_port = 2342;
      };
    };

    nginx.virtualHosts.${config.services.grafana.domain} = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.port}";
        proxyWebsockets = true;
      };
    };
  };
}
