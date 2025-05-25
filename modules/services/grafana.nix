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

    nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
      };
    };
  };
}
