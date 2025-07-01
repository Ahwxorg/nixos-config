{
  services = {
    miniflux = {
      enable = false; # if enable then postgres mad
      createDatabaseLocally = false;
      config = {
        # CLEANUP_FREQUENCY = 48;
        LISTEN_ADDR = "localhost:8011";
      };
      adminCredentialsFile = /etc/miniflux/adminCredentialsFile;
    };
    nginx.virtualHosts."feed.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:8011";
        proxyWebsockets = true;
      };
    };
  };
}
