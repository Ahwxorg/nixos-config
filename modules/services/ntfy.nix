let
  hostname = "notify.liv.town";
  port = 2586;
  url = "https://" + hostname;
in
{
  services = {
    ntfy-sh = {
      enable = true;
      settings = {
        base-url = url;
        listen-http = "127.0.0.1:${toString port}";
        behind-proxy = true;
        visitor-attachment-daily-bandwidth-limit = "10M";
        visitor-request-limit-burst = 5;
        visitor-request-limit-replenish = "15s";
      };
    };
    nginx.virtualHosts.${hostname} = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString port}";
        proxyWebsockets = true;
      };
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
