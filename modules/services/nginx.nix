{ pkgs, config, lib, ... }: {
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
    };
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = false;
    recommendedProxySettings = true;
    clientMaxBodySize = lib.mkDefault "10G";

    # Hardened TLS and HSTS preloading
    appendHttpConfig = ''
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
  };
}
