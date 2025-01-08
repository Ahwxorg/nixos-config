{ ... }:
{
  services = {
    nginx.virtualHosts."curate.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:8081";
        proxyWebsockets = true;
      };
    };
  };
}