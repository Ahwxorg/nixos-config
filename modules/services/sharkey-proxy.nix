{ ... }:
{
  services = {
    nginx.virtualHosts."quack.social" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/quack.social/cert.pem";
      sslCertificateKey = "/var/lib/acme/quack.social/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Host $remote_addr;
        '';
      };

      locations."/wiki/" = {
        # Nepenthis
        proxyPass = "http://localhost:8893";
        extraConfig = ''
          proxy_set_header X-Prefix '/wiki';
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Host $remote_addr;
          proxy_buffering off;
        '';
      };
      locations."wp-login.php".return = "301 https://hil-speed.hetzner.com/10GB.bin";
    };
  };
}
