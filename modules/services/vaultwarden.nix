{
  config,
  host,
  pkgs,
  username,
  ...
}:
let
  baseRepo = "ssh://liv@dandelion:9123/spinners/rootvol/backups/${host}";
in
{
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      config = {
        SIGNUPS_ALLOWED = false;
        ENABLE_WEBSOCKET = true;
        SENDS_ALLOWED = true;
        INVITATIONS_ENABLED = true;
        EMERGENCY_ACCESS_ALLOWED = true;
        EMAIL_ACCESS_ALLOWED = true;
        DOMAIN = "https://passwords.liv.town";
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = 8003;
      };
    };
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts = {
        "passwords.liv.town" = {
          forceSSL = true;
          sslCertificate = "/var/lib/acme/liv.town/cert.pem";
          sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}/";
            proxyWebsockets = true;
          };
        };
      };
    };
    borgbackup.jobs."violet-vaultwarden" = {
      paths = [ "/var/lib/bitwarden_rs" ];
      repo = "${baseRepo}/var-vaultwarden";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
      preHook = ''
        systemctl stop vaultwarden
      '';
      postHook = ''
        systemctl start vaultwarden
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (vaultwarden) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (vaultwarden) completed succesfully with exit status $exitStatus"
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
