{ config, ... }:
{
  services = {
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/secrets/cache-private-key.pem";
    };

    nginx.virtualHosts."violet.booping.local" = {
      forceSSL = false;
      # sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      # sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };
}
