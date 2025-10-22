{ pkgs, config, ... }:
{
  services.prosody = {
    enable = true;
    # user = "prosody";
    user = config.services.nginx.user;
    modules = {
      welcome = true;
      websocket = true;
      watchregistrations = true;
    };
    httpFileShare.domain = "uploads.liv.town";
    admins = [ "liv@liv.town" ];
    allowRegistration = false;
    ssl.cert = "/var/lib/acme/liv.town/cert.pem";
    ssl.key = "/var/lib/acme/liv.town/key.pem";
    virtualHosts."liv.town" = {
      enabled = true;
      domain = "liv.town";
      ssl.cert = "/var/lib/acme/liv.town/fullchain.pem";
      ssl.key = "/var/lib/acme/liv.town/key.pem";
    };
    muc = [
      {
        domain = "conference.liv.town";
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [
    # File transfer proxy
    5000
    # Client connections
    5222
    # Client connections (direct TLS)
    5223
    # Server-to-server connections
    5269
    # Server-to-server connections (direct TLS)
    5270
  ];
}
