let
  hostname = "notify.liv.town";
  port = 2586;
  url = "https://" + hostname;
in {
  services = {
    ntfy-sh = {
      enable = true;
      settings = {
        base-url = url;
        listen-http = "127.0.0.1:${toString port}";
        behind-proxy = true;
      };
    };
    nginx.virtualHosts.${hostname} = {
      useACMEHost = "liv.town";
      forceSSL = true;
      locations."/" = { proxyPass = "http://127.0.0.1:${toString port}"; };
    };
    frp.settings.proxies = [
      {
        name = "http";
        type = "tcp";
        localIP = "localhost";
        localPort = port;
        remotePort = port;
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [ port ];
}
