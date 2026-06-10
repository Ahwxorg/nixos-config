{
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    nginx.virtualHosts."share.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:53842";
      };
    };
    nginx.virtualHosts."share.ahwx.org" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/ahwx.org/cert.pem";
      sslCertificateKey = "/var/lib/acme/ahwx.org/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:53842";
      };
    };
  };
}
