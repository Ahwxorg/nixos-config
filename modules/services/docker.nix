{ ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    # enableNvidia = true;
  };
  
  users.users.liv = {
    extraGroups = [ "docker" ];
  };
}
