{ config, host, ... }:
{
  services = {
    prometheus = {
      enable = true;
      port = 9001;
      exporters = {
        smartctl.enable = true;
        zfs.enable = true;
        node = {
          enable = true;
          enabledCollectors = [
            "systemd"
            "cpu"
            "cpufreq"
            "diskstats"
            "filesystem"
            "loadavg"
            "meminfo"
            "netdev"
            "stat"
            "time"
            "uname"
            "hwmon"
            "bcache"
            "conntrack"
            "dmi"
            "nvme"
            "thermal_zone"
            "zfs"
          ];
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
        {
          job_name = "${host} - smartctl";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.smartctl.port}" ];
            }
          ];
        }
        {
          job_name = "${host} - zfs";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.zfs.port}" ];
            }
          ];
        }
      ];
    };
    loki = {
      enable = true;
      configuration = {
        auth_enabled = false;
        server.http_listen_port = 9003;

        common = {
          path_prefix = "/var/lib/loki";
          replication_factor = 1;
          ring.kvstore.store = "inmemory";
        };

        schema_config.configs = [
          {
            from = "2024-01-01";
            store = "tsdb";
            object_store = "filesystem";
            schema = "v13";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }
        ];

        storage_config.filesystem.directory = "/var/lib/loki/chunks";

        limits_config = {
          retention_period = "90d";
          reject_old_samples = true;
          reject_old_samples_max_age = "8h";
        };

        compactor = {
          working_directory = "/var/lib/loki/compactor";
          delete_request_store = "filesystem";
          retention_enabled = true;
        };
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      9001
      9003
    ];
  };
}
