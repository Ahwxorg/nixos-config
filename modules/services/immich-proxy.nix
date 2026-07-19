{
  services = {
    nginx.virtualHosts."photos.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/".return = "301 https://photos.ahwx.org";
    };
  };
}
