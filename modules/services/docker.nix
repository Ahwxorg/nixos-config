{ username, ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    # enableNvidia = true;
  };
  
  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
}
