{ ... }:
{
  services.radicale = {
    enable = true;
    settings = {
      server.hosts = [ "0.0.0.0:5232" ];
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/etc/radicale/htpasswd";
        htpasswd_encryption = "bcrypt";
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "plan.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/radicale/" = {
          proxyPass = "http://127.0.0.1:5232/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Host $remote_addr;
            proxy_pass_header Authorization;
          '';
        };
        locations."/" = {
          proxyPass = "http://127.0.0.1:5232/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_connect_timeout       300;
            proxy_send_timeout          300;
            proxy_read_timeout          300;
            send_timeout                300;
          '';
        };
        locations."^/.well-known/carddav".return = "301 /radicale/";
        locations."^/.well-known/caldav".return = "301 /radicale/";
        locations."^/remote.php/webdav".return = "301 /radicale/";
        locations."^/remote.php/caldav".return = "301 /radicale/caldav/";
        locations."^/remote.php/carddav".return = "301 /radicale/carddav/";
      };
    };
  };
}
