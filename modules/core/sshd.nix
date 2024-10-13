{ ... }: 
{
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      PermitRootLogin = "no";
      LoginGraceTime = 0;
    };
  };

  users.users.liv.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXi00z/rxVrWLKgYr+tWIsbHsSQO75hUMSTThNm5wUw liv@lila" ];
}
