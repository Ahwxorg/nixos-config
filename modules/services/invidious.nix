{ config, ... }:
{
  services.invidious = {
    enable = true;
    port = 8001;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "video.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/".proxyPass = "http://127.0.0.1:${toString config.services.invidious.port}";
      };
    };
  };
}
