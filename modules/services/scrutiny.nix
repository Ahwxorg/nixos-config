{ ... }:

{
  services.scrutiny = {
    enable = true;
    collector.enable = true;
    settings.web.listen.port = 8181;
    settings.notify.urls = [
      "ntfy://notify.liv.town/violet"
    ];
  };

  services.nginx.virtualHosts."scrutiny.liv.town" = {
    locations."/" = {
      proxyPass = "http://localhost:8181/";
    };
  };
}
