{
  services = {
    nginx.virtualHosts."photos.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        # proxyPass = "http://unix:${toString config.services.anubis.instances.librey.settings.BIND}";
        proxyPass = "http://172.16.10.130:2283";
        proxyWebsockets = true;
      };
    };
  };
}
