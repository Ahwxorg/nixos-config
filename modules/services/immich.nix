{ config, ... }:
{
  # services.immich = {
  # enable = true;
  # port = 2283;
  # mediaLocation = "/spinners/rootvol/immich/";
  # openFirewall = true;
  # machine-learning.enable = true;
  # };

  # services.nginx.virtualHosts."" = {
  #   forceSSL = true;
  #   locations."/" = {
  #     proxyPass = "http://localhost:${toString config.services.immich.port}";
  #     proxyWebsockets = true;
  #     recommendedProxySettings = true;
  #     extraConfig = ''
  #       client_max_body_size 50000M;
  #       proxy_read_timeout   600s;
  #       proxy_send_timeout   600s;
  #       send_timeout         600s;
  #     '';
  #   };
  # };
}
