{ config, host, ... }:
{
  imports = [ ./email.nix ];
  services.scrutiny = {
    # Enable based on name of host
    enable =
      if (host == "dandelion") then
        true
      else if (host == "sunflower") then
        true
      else
        false;
    collector.enable = true;
    settings.web.listen.port = 8181;
    settings.notify.urls = [
      # "ntfy://${config.liv.variables.ntfyURL}/${config.networking.hostName}"
      "ntfy://notify.liv.town/${config.networking.hostName}"
    ];
  };

  services.smartd = {
    enable = true;
    autodetect = true;
    notifications = {
      wall = {
        enable = true;
      };
      mail = {
        enable = true;
        sender = config.liv.variables.senderEmail;
        recipient = config.liv.variables.email;
      };
    };
  };

  # services.nginx.virtualHosts."" = {
  #   locations."/" = {
  #     proxyPass = "http://localhost:8181/";
  #   };
  # };
}
