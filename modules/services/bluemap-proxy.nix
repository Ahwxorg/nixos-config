{ ... }:
{
  services = {
    nginx.virtualHosts."maps.quack.social" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/quack.social/cert.pem";
      sslCertificateKey = "/var/lib/acme/quack.social/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:25566";
        proxyWebsockets = true;
      };
    };
  };
}
