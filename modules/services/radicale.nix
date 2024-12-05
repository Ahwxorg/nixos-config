{ ... }:
{
  services.radicale = {
    enable = true;
    settings = {
      server.hosts = [ "0.0.0.0:5232" ];
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/home/liv/radicaleusers";
        htpasswd_encryption = "bcrypt";
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "calendar.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        # locations."/radicale/" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:5232/";
          # extraConfig = ''
          #   # proxy_set_header X-Script-Name /radicale;
          #   # proxy_set_header X-Script-Name /;
          #   proxy_pass_header Authorization;
          # '';
        };
      };
    };
  };
}
