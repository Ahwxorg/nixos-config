{ config, host, ... }:
{
  services = {
    prometheus = {
      enable = true;
      port = 9001;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9002;
        };
        smokeping = {
          enable = true;
          hosts = [
            "172.16.10.1"
            "172.16.10.2"
            "9.9.9.9"
            "149.112.112.112"
          ];
        };
      };
      scrapeConfigs = [
        {
          job_name = "${config.networking.hostName}";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
            }
          ];
        }
        {
          job_name = "${host} - smokeping";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.smokeping.port}" ];
            }
          ];
        }
      ];
    };
  };
  # networking.firewall = {
  # allowedTCPPorts = [
  # 9001
  # ];
  # };
}
