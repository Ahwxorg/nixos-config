{
  username,
  pkgs,
  lib,
  ...
}:
{
  virtualisation.docker = {
    package = lib.mkDefault pkgs.docker_29;
    enable = true;
    autoPrune.enable = true;
    # enableNvidia = true;
  };

  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
}
