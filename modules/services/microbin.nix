{
  services = {
    microbin = {
      enable = false; # First, find a way to block everything BUT /upload.
      settings = {
        MICROBIN_WIDE = true;
        MICROBIN_MAX_FILE_SIZE_UNENCRYPTED_MB = 2048;
        MICROBIN_PUBLIC_PATH = "https://paste.liv.town/";
        MICROBIN_BIND = "127.0.0.1";
        MICROBIN_PORT = 8070;
        MICROBIN_HIDE_LOGO = true;
        MICROBIN_HIGHLIGHTSYNTAX = true;
        MICROBIN_HIDE_HEADER = true;
        MICROBIN_HIDE_FOOTER = true;
      };
    };
    nginx.virtualHosts."paste.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:8080";
        proxyWebsockets = true;
      };
    };
  };
}
