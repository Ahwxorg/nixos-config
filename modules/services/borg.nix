{
  pkgs,
  config,
  username,
  ...
}:
let
  hostname = "violet";
  baseRepo = "ssh://liv@dandelion:9123/spinners/rootvol/backups/${hostname}";
in
{
  services.borgbackup.jobs = {
    "violet-minecraft" = {
      paths = [
        "/home/liv/MinecraftDocker"
      ];
      repo = "ssh://liv@dandelion:9123/spinners/rootvol/backups/violet/MinecraftDocker-tulip";
      encryption.mode = "none";
      compression = "auto,zstd,10";
      startAt = [ "3:00" ];
      postHook = ''
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-minecraft) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-minecraft) completed succesfully with exit status $exitStatus"
        fi
      '';
      user = "${username}";
      extraCreateArgs = [
        "--stats"
      ];
      environment = {
        BORG_RSH = "ssh -p 9123 -i /home/liv/.ssh/id_ed25519";
      };
    };
    "violet-lib" = {
      paths = [
        "/var/lib"
      ];
      exclude = [
        "/var/lib/matrix-synapse"
        "/var/lib/mautrix-signal"
        "/var/lib/mautrix-whatsapp"
        "/var/lib/bitwarden_rs"
      ];
      repo = "${baseRepo}/var-lib";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
      postHook = ''
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-lib) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-lib) completed succesfully with exit status $exitStatus"
        fi
      '';
      # user = "${username}";
      extraCreateArgs = [
        "--stats"
      ];
      environment = {
        BORG_RSH = "ssh -p 9123 -i /home/liv/.ssh/id_ed25519";
      };
    };
  };
}
