let
  borgbackupMonitor =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    with lib;
    {
      key = "borgbackupMonitor";
      _file = "borgbackupMonitor";
      config.systemd.services =
        {
          "notify-problems@" = {
            enable = true;
            serviceConfig.User = "liv";
            environment.SERVICE = "%i";
            script = ''
              ${pkgs.curl}/bin/curl -d "$SERVICE FAILED! - service $SERVICE on host $(hostname) failed, run journalctl -u $SERVICE for details."
            '';
          };
        }
        // flip mapAttrs' config.services.borgbackup.jobs (
          name: value:
          nameValuePair "borgbackup-job-${name}" {
            unitConfig.OnFailure = "notify-problems@%i.service";
          }
        );

      # optional, but this actually forces backup after boot in case laptop was powered off during scheduled event
      # for example, if you scheduled backups daily, your laptop should be powered on at 00:00
      config.systemd.timers = flip mapAttrs' config.services.borgbackup.jobs (
        name: value:
        nameValuePair "borgbackup-job-${name}" {
          timerConfig.Persistent = true;
        }
      );
    };

in
{
  imports = [ borgbackupMonitor ];
  services = {
    borgbackup.jobs.liv-violet = {
      paths = "/home/liv";
      encryption.mode = "none";
      environment.BORG_RSH = "ssh -i /home/liv/.ssh/id_ed25519";
      repo = "ssh://liv@100.115.178.50:9123/spinners/rootvol/backups/hosts/violet";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}
