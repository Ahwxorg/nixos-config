{ config, ... }:
{
  services.scrutiny = {
    enable = true;
    collector.enable = true;
    settings.web.listen.port = 8181;
    settings.notify.urls = [
      # "ntfy://${config.liv.variables.ntfyURL}/${config.networking.hostName}"
      "ntfy://notify.liv.town/${config.networking.hostName}"
    ];
  };

  # services.smartd = {
  #   enable = true;
  #   autodetect = true;
  #   notifications = {
  #     mail = {
  #       enable = true;
  #       # mailer = "/path/to/mailer/binary"; # Need to get system emails working first
  #       sender = "${config.liv.variables.fromEmail}";
  #       recipient = "${config.liv.variables.toEmail}";
  #     };
  #   };
  # };

  # services.nginx.virtualHosts."" = {
  #   locations."/" = {
  #     proxyPass = "http://localhost:8181/";
  #   };
  # };
}
