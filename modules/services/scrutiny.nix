{ config, ... }: {
  services.scrutiny = {
    enable = true;
    collector.enable = true;
    settings.web.listen.port = 8181;
    settings.notify.urls = [
      "ntfy://${config.liv.variables.ntfyURL}/${config.networking.hostName}"
    ];
  };

  # services.nginx.virtualHosts."" = {
  #   locations."/" = {
  #     proxyPass = "http://localhost:8181/";
  #   };
  # };
}
