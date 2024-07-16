{ config, ... }:
{


  services.nextcloud = {
    enable = true;
    home = "/home/liv/nextcloud";
    https = true;
    configureRedis = true; # caching
    maxUploadSize = "10G";
    hostname = "cloud.liv.town";

    settings = {
      trusted_domains = [
        "cloud.liv.town"
      ];
    };

    extraOptions.enabledPreviewProviders = [
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

  security.acme = {
    acceptTerms = true;   
    certs = { 
      ${config.services.nextcloud.hostName}.email = "ahwx@ahwx.org"; 
    }; 
  };
}
