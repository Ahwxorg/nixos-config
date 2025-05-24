{
  pkgs,
  config,
  lib,
  ...
}:
{

  security.acme = {
    acceptTerms = true;
    defaults.email = lib.mkDefault "ahwx@ahwx.org";
    certs = {
      "liv.town" = {
        domain = "*.liv.town";
        extraDomainNames = [ "liv.town" ];
        group = config.services.nginx.group;
        dnsProvider = "desec";
        environmentFile = "/home/liv/desec.env"; # location of your DESEC_TOKEN=[value]
        webroot = null;
      };
      "quack.social" = {
        domain = "*.quack.social";
        extraDomainNames = [ "quack.social" ];
        group = config.services.nginx.group;
        dnsProvider = "desec";
        environmentFile = "/home/liv/desec.env"; # location of your DESEC_TOKEN=[value]
        webroot = null;
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = false;
    recommendedProxySettings = true;
    clientMaxBodySize = lib.mkDefault "10G";

    defaultListen =
      let
        listen = [
          {
            addr = "[::]";
            port = 80;
            extraParameters = [ "proxy_protocol" ];
          }
          {
            addr = "[::]";
            port = 443;
            ssl = true;
            extraParameters = [ "proxy_protocol" ];
          }
        ];
      in
      map (x: (x // { addr = "0.0.0.0"; })) listen ++ listen;

    # Hardened TLS and HSTS preloading
    appendHttpConfig = ''
      # Proxying
      # real_ip_header proxy_protocol;

      server {
        listen 80   proxy_protocol;
        listen 443  ssl proxy_protocol;
        # set_real_ip_from 10.7.0.0/24;
      }

      ssl_certificate /var/lib/acme/quack.social/cert.pem;
      ssl_certificate_key /var/lib/acme/quack.social/key.pem;

      proxy_set_header Host            $host;
      proxy_set_header X-Real-IP       $proxy_protocol_addr;
      proxy_set_header X-Forwarded-For $proxy_protocol_addr;

      # Add HSTS header with preloading to HTTPS requests.
      # Do not add HSTS header to HTTP requests.
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;

      # # Enable CSP for your services. (THIS BREAKS SHARKEY!!!!!!!)
      # add_header Content-Security-Policy "default-src 'self'; base-uri 'self'; frame-src 'self'; frame-ancestors 'self'; form-action 'self';" always;

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      #   # This might create errors
      #   # proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";

      # Most important headers
      add_header meow "nyaa";
      add_header matrix "@liv:liv.town";
      add_header pronouns "any but neopronouns";
      add_header locale "[en_US, nl_NL]";
    '';
    appendConfig = ''
      # https://docs.nginx.com/nginx/admin-guide/load-balancer/using-proxy-protocol/
      # set_real_ip_from 213.210.34.27;

      # real_ip_header proxy_protocol;

      # proxy_set_header Host               $host;
      # proxy_set_header X-Real-IP          $proxy_protocol_addr;
      # proxy_set_header X-Forwarded-For    $proxy_protocol_addr;
      # proxy_set_header X-Forwarded-Proto  $scheme;
      # proxy_set_header X-Forwarded-Host   $host;
      # proxy_set_header X-Forwarded-Server $host;
    '';
  };
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
  };
}
