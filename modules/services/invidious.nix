{ config, ... }:
{
  services.invidious = {
    enable = true;
    port = 8001;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    clientMaxBodySize = "40M";
    virtualHosts = {
      "video.liv.town" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://127.0.0.1:${toString config.services.invidious.port}";
      };
    };
  };
}
