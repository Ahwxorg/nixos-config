{ ... }:

{
  services = {
    lidarr = {
      enable = true;
    };

    nginx.virtualHosts = {
      "listen.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8686/";
          proxyWebsockets = true;
        };
      };
    };
  };
}
