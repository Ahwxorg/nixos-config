{ pkgs, config, ... }:
let
  hostname = "violet";
  repo = "ssh://dandelion.booping.local:${toString config.services.openssh.ports}/spinners/rootvol/backups/${hostname}";
in
{
  services.borgbackup.jobs = {
    "violet-minecraft" = {
      paths = [
        "/home/liv/MinecraftDocker"
      ];
      repo = "${repo}/MinecraftDocker-tulip";
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
    # "violet-random" = {
    #   paths = [
    #     "/random"
    #   ];
    #   exclude = [
    #     "/random/a"
    #     "/random/a"
    #   ];
    #  encryption = {
    #    mode = "";
    #    passCommand = "";
    #  };
    #  environment.BORG_RSH = "ssh -i ${config.sops.secrets."ssh_private_key_violet".path}";
    #  repo = "${repo}/violet/random";
    #  compression = "auto,zstd";
    #  startAt = "daily";
    #  postHook = ''
    #    if [ $exitStatus -eq 2 ]; then
    #      ${pkgs.ntfy-sh}/bin/ntfy send https://ntfy.${domain}/nixbox "BorgBackup: nixbox backup failed with errors"
    #    else
    #      ${pkgs.ntfy-sh}/bin/ntfy send https://ntfy.${domain}/nixbox "BorgBackup: nixbox backup completed succesfully with exit status $exitStatus"
    #    fi
    #  '';
    # };
  };
}
