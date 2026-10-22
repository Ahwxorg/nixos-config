{ username, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.autofs5
    pkgs.fuse3
    pkgs.sshfs
  ];

  users.users.${username}.extraGroups = [ "fuse" ];

  environment.etc."fuse.conf".text = "user_allow_other\n";

  services.rpcbind.enable = true;

  services.openssh.knownHosts = {
    "flora" = {
      hostNames = [
        "flora"
        "10.13.37.42"
        "liv.town"
        "robotgirl.zip"
      ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpv/jw33/9kzOeeH7qDmGA3tp7HEjCAW1xvqrVKB1UW";
    };
  };

  fileSystems."/mnt/flora/home" = {
    device = "${username}@flora:/spinners/ahwx";
    fsType = "fuse.sshfs";
    options = [
      "IdentityFile=/home/${username}/.ssh/id_ed25519"
      "allow_other"
      "default_permissions"
      "uid=1000"
      "gid=100"
      "reconnect"
      "ServerAliveInterval=15"
      "ServerAliveCountMax=3"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.mount-timeout=15"
      "x-systemd.pull-on-path-updates"
      "x-systemd.makefs"
      "localomount"
    ];
  };

}
