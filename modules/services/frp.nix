{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      serverAddr = "";
      serverPort = 7000;
      auth.method = "token";
      auth.token = "";
      proxies = [
        {
          name = "http";
          type = "tcp";
          localIP = "localhost";
          localPort = 80;
          remotePort = 80;
        }
        {
          name = "https";
          type = "tcp";
          localIP = "localhost";
          localPort = 443;
          remotePort = 443;
        }
      ];
    };
  };
}
