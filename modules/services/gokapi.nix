{ lib, config, pkgs, ... }: {
  services = {
    nginx.virtualHosts."share.liv.town" = {
      useACMEHost = "liv.town";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:53842";
      };
    };
  };
}
