{ pkgs, ... }:
{
  networking.firewall.allowedUDPPorts = [ 5353 ];
  networking.firewall.allowedTCPPorts = [ 57621 ];

  # Spotifyd must have credentials, to do so, run:
  # spotifyd --username <USER> --password <PASS>

  # If you experience any issues, run:
  # rm -fr ~/.cache/spotify

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "Liv";
        password = "foo"; # TODO: add agenix
      };
    };
  };
}
