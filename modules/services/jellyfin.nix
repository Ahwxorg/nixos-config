{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  services = {
    jellyfin = {
      enable = true;
    };
    nginx.virtualHosts = {
      "stream.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/" = {
          proxyPass = "http://localhost:8096";
          proxyWebsockets = true;
        };
      };
    };
  };
}
