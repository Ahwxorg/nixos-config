{ ... }:
{
  services = {
    nginx.virtualHosts."quack.social" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
    };
  };
}
