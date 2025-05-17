{ lib, config, ... }:
{
  services = {
    dnsmasq = {
      enable = true;
      settings = {
        cache-size = 10000;
        server = [ "127.0.0.1#53" ];
      };
    };
  };
}
