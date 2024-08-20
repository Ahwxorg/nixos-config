{ config, ... }:
{
  security.acme = {
    acceptTerms = true;
    preliminarySelfsigned = false;
    defaults = {
      email = "ahwx@ahwx.org";
    };
  };

  services.nextcloud = {
    enable = true;
    home = "/var/nextcloud/home";
    https = true;
    configureRedis = false; # caching
    maxUploadSize = "10G";
    hostName = "cloud.liv.town";

    config = {
      adminuser = "liv";
      adminpassFile = "/var/nextcloud/AdminPass";
    };

    settings = {
      trusted_domains = [
        "cloud.liv.town"
      ];
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Hardened TLS and HSTS preloading
    appendHttpConfig = ''
      # Add HSTS header with preloading to HTTPS requests.
      # Do not add HSTS header to HTTP requests.
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;

      # Enable CSP for your services.
      #add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

      # Minimize information leaked to other domains
      add_header 'Referrer-Policy' 'origin-when-cross-origin';

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      # This might create errors
      # proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
    '';

    virtualHosts = {
      "${config.services.nextcloud.hostName}" = {
        enableACME = true;
        forceSSL = true;
        locations = {
          "/".proxyPass = "http://localhost:8080";
          "/".proxyWebsockets = true;
        };
      };
    };
  };
}
