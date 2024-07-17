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

  virtualisation.oci-containers = {
    backend = "docker";
    containers."livdottown" = {
      image = "ghcr.io/ahwxorg/liv.town:latest";
      ports = [
        "4321:4321/tcp"
      ];
    };
  };
}
