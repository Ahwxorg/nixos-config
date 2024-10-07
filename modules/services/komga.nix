{ lib, config, pkgs, ... }: {
  services.komga = {
    enable = true;
    port = 2872;
    stateDir = "/var/lib/komga";
    openFirewall = true;
    user = "liv";
  };

  services = {
    nginx.virtualHosts."read.liv.town" = {
      useACMEHost = "liv.town";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:2872";
      };
    };
  };

}
