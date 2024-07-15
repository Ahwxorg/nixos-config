{ pkgs, ... }: 
{
  networking = {
    networkmanager.enable = true;
    nameservers = [ "9.9.9.9" ];
    firewall = {
      enable = true;
      # allowedTCPPorts = [ 22 80 443 59010 59011 ];
      # allowedUDPPorts = [ 59010 59011 ];
      # allowedUDPPortRanges = [
        # { from = 4000; to = 4007; }
        # { from = 8000; to = 8010; }
      # ];
    };
  };

  # environment.systemPackages = with pkgs; [
  #   networkmanagerapplet
  # ];
}
