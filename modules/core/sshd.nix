{ lib, config, ... }:
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

  users.users.liv.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXi00z/rxVrWLKgYr+tWIsbHsSQO75hUMSTThNm5wUw liv@sakura" # sakura
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHv2zxCy22KU1tZOH2hA1p8fWVpOSrTYF68+3E5r330O liv@ichiyo" # ichiyo
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEDltZ7vfyrLrl32TIWCC3iUx40TrCtIz6Ssi/SZvikg liv@zinnia" # zinnia; retired
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQtG69zrMFsoHForwZEi66y1tPvctqg1OgjQFrF3OI+ liv@iris" # iris
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINKI2KQn97mykFLIaMUWMftA1txJec9qW56hAMj5/MhE liv@dandelion" # dandelion
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILwDS8tXjGjUtk3eQAaPf0S0f9JgwEGPlNYQ7OvACX1Z liv@imilia" # imilia
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7Qlz0vKb8EtqiyRRz1PLmcWR9mxq39BaAcUU4Ls2pM liv@myrtle" # myrtle

    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO7mHVQp99G0osUAtnVoq5TARR8x5wjCkdbe7ChnzLRa liv@azalea" # linux phone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2nsQHyWnrmuQway0ehoMUcYYfhD8Ph/vpD0Tzip1b1 liv@meow" # xz1c
  ];
}
