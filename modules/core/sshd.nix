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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXi00z/rxVrWLKgYr+tWIsbHsSQO75hUMSTThNm5wUw liv@sakura" # main laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2nsQHyWnrmuQway0ehoMUcYYfhD8Ph/vpD0Tzip1b1 liv@meow" # main phone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHv2zxCy22KU1tZOH2hA1p8fWVpOSrTYF68+3E5r330O liv@ichiyo" # 2nd laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO7mHVQp99G0osUAtnVoq5TARR8x5wjCkdbe7ChnzLRa liv@azalea" # linux phone
  ];
}
