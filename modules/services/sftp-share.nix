{ pkgs, ... }:
{
  services.openssh.extraConfig = "
    Match Group sftpusers
      ChrootDirectory /spinners/uploads
      ForceCommand internal-sftp
      AllowTcpForwarding no
      X11Forwarding no
  ";

  users.groups.sftpusers = { };

  users.users.lucas = {
    group = "sftpusers";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRlHUD6WwNuUqSlIUWWcobsLoRKZLQE6PW7RcHMFPu3E3v0RBXNX86hWRaS/ziB0S6bOttflfHJzmV2KUgDb0+ChUvHYCuLR9d6KxDlbOzTWog1VQ/+l7bc4vrxEfaMfi6WffsXGmAN43QAc3H17KY3Z7XmZ34b88hqyKIhGyhdTR5jT8IxNyXpPab/xT42s6dJQ20+n9Brg5VHpcyF/FKDnF3axhMkLV1pOd50aqDDOQepJlTXGxnnWRuwhM0WuRgpryJ7r/P7W9sDKSpreIalrmO0WtQ7RMfvc2Xvl7vb08J1lTwMWIRlwMqCqhQiQP2pNyId2uos99Oo53UX9KXW0jFD5zNMIND1e51SQWa8FibJB+ujj4kRUs7YCrZBR8Ki4JWAZCUPnIYomTtf/iDwWZa2wpU6sIqXlp+vWkoTdN8DTg2IGjFaHn6kRzMBlewwAkW/9TMNRVEXA4Y8JjlWW7TE/lT+fWmt/gAse3AwklXVj9Evy9zemKw8PIrIpk= lucas@MacbookAir"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvBUqdUraJCNVK7t8Rlhf7zc/etxZK0/L3DGKwY10Zl lucas@orion"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAR49vTfzwC2cd09nE2zAsi5GvjLKyYSXsi072hwmMV2 liv@fragile"
    ];
  };
}
