{ pkgs, config, ... }:
let
  hostname = "violet";
  repo = "ssh://dandelion:${toString config.services.openssh.ports}/spinners/rootvol/backups/${hostname}";
in
{
  services.borgbackup.jobs = {
    "violet-minecraft" = {
      paths = [
        "/home/liv/MinecraftDocker"
      ];
      repo = "${repo}/MinecraftDocker-tulip";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
      postHook = ''
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://ntfy.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-minecraft) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://ntfy.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-minecraft) completed succesfully with exit status $exitStatus"
        fi
      '';
    };
    "violet-lib" = {
      paths = [
        "/var/lib"
      ];
      repo = "${repo}/var-lib";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
      postHook = ''
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://ntfy.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-lib) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://ntfy.liv.town/${hostname} "borgbackup: ${hostname} backup (violet-lib) completed succesfully with exit status $exitStatus"
        fi
      '';
    };
  };
}
