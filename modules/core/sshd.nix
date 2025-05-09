{ lib, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      AllowUsers = null;
      PermitRootLogin = "no";
      LoginGraceTime = 0;
    };
  };

  users.users.liv.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXi00z/rxVrWLKgYr+tWIsbHsSQO75hUMSTThNm5wUw liv@sakura" # main laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2nsQHyWnrmuQway0ehoMUcYYfhD8Ph/vpD0Tzip1b1 liv@meow" # main phone
  ];
}
