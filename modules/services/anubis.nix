{ config, lib, ... }:
{
  users.users.nginx.extraGroups = [ config.users.groups.anubis.name ];
  services.anubis = {
    defaultOptions = {
      enable = true;
      settings = {
        SERVE_ROBOTS_TXT = true;
      };
    };
  };
}
