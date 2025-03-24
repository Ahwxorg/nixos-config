{ ... }: {
  services.nextcloud = {
    enable = true;
    config.dbtype = "sqlite";
    configureRedis = true;
    home = "/home/liv/nextcloud";
    config.adminpassFile = "/run/nextcloud/adminpassFile";
    maxUploadSize = "25G";
    https = true;
    hostName = "dandelion.srv.liv.town";
    settings = {
      trusted_domains = [
        "dandelion.srv.liv.town"
        "files.dandelion.srv.liv.town"
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
}
