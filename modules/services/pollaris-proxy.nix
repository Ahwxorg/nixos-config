{ ... }:
{
  services = {
    nginx.virtualHosts."pick.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://192.168.122.100";
      };

      locations."wp-login.php".return = "301 https://hil-speed.hetzner.com/10GB.bin";
    };
  };
}
