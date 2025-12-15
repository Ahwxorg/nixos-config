{
  pkgs,
  config,
  username,
  ...
}:
let
  nexturl = "cloud.liv.town";
in
{
  home.packages = with pkgs; [
    nextcloud-client
  ];
  systemd.user = {
    services.nextcloud-autosync = {
      Unit = {
        Description = "Auto sync Nextcloud";
        After = "network-online.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.nextcloud-client}/bin/nextcloudcmd -h -n --path /music /home/${username}/cloud/music https://${nexturl}";
        TimeoutStopSec = "180";
        KillMode = "process";
        KillSignal = "SIGINT";
      };
      Install.WantedBy = [ "multi-user.target" ];
    };
    timers.nextcloud-autosync = {
      Unit.Description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 60 minutes";
      Timer.OnBootSec = "5min";
      Timer.OnUnitActiveSec = "30min";
      Install.WantedBy = [
        "multi-user.target"
        "timers.target"
      ];
    };
    startServices = true;
  };
}
