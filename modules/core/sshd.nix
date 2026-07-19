{
  lib,
  config,
  username,
  ...
}:
{
  services.openssh = {
    enable = true;
    ports = [ 9123 ];
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      AllowUsers = null;
      PermitRootLogin = "no";
      LoginGraceTime = 0;
    };
  };

  networking.firewall.allowedTCPPorts = config.services.openssh.ports;

  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHv2zxCy22KU1tZOH2hA1p8fWVpOSrTYF68+3E5r330O liv@ichiyo" # ichiyo
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQtG69zrMFsoHForwZEi66y1tPvctqg1OgjQFrF3OI+ liv@iris" # iris
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAR49vTfzwC2cd09nE2zAsi5GvjLKyYSXsi072hwmMV2 liv@azalea" # azalea
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOh90Kba/KNwWafa26+eBpNFer4qQ0KgF35Q+9gteyo/ liv@clover" # clover
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD8DIqgrOXuI/EeOD7tSfpDikJfj9CmoghemkwkL0Dh openpgp:0x04CCA7CF" # yubi
  ];
}
