{ ... }:
{
  services = {
    readarr = {
      enable = true;
    };

    nginx.virtualHosts = {
      "read.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8787/";
          proxyWebsockets = true;
        };
      };
    };
  };
}
