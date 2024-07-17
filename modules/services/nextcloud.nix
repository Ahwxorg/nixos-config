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
    virtualHosts.${config.services.nextcloud.hostName} = {
      enableACME = true;
      addSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8080";
        proxyWebsockets = true;
      };
    };
  };
}
