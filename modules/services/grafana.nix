{
  config,
  host,
  username,
  pkgs,
  ...
}:
let
  baseRepo = "ssh://liv@dandelion:9123/spinners/rootvol/backups/${host}";
in
{
  services = {
    grafana = {
      enable = true;
      settings.server = {
        domain = "monitoring.liv.town";
        http_addr = "127.0.0.1";
        http_port = 2342;
      };
    };

    nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
      };
    };
    borgbackup.jobs."violet-grafana" = {
      paths = [ "/var/lib/grafana" ];
      repo = "${baseRepo}/var-grafana";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
      preHook = ''
        systemctl stop grafana
      '';
      postHook = ''
        systemctl start grafana
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (grafana) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (grafana) completed succesfully with exit status $exitStatus"
        fi
      '';
      user = "root";
      extraCreateArgs = [
        "--stats"
      ];
      environment = {
        BORG_RSH = "ssh -p 9123 -i /home/${username}/.ssh/id_ed25519";
      };
    };
  };
}
