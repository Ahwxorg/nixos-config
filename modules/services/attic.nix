{ config, ... }:
{
  services = {
    atticd = {
      enable = true;

      # File containing the server token in the following format:
      #   ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64=<...>
      # You can generate the token by running the following command:
      #   openssl genrsa -traditional 4096 | base64 -w0
      environmentFile = config.sops.secrets.atticdEnvironment.path;
      settings = {
        # Listen on some port. Replace it!
        listen = "[::]:8060";
        # The two lines below should be set to the URL where your Attic cache will be available.
        allowed-hosts = [ "cache.liv.town" ];
        # Apparently it's very important this ends in a "/"
        api-endpoint = "https://cache.liv.town/";
        jwt = { };
        database = {
          # I used Postgres here, but if you leave it empty
          # it will use an in-memory SQLite DB instead.
          # url = "postgresql://atticd@127.0.0.1/atticd";
          # heartbeat = true;
        };
        storage = {
          # You could also use S3 here. But nah lol shit's expensive.
          type = "local";
          # Leave this empty to use the default path,
          # or change it to some path that Attic can write to.
          path = "/mnt/nfs/violet/nix";
        };
      };
    };
    #anubis.instances.atticd = {
    #  settings = {
    #    TARGET = "http://localhost:8060";
    #    BIND = "/run/anubis/anubis-atticd/anubis.sock";
    #    METRICS_BIND = "/run/anubis/anubis-atticd/anubis.sock";
    #  };
    #};
    nginx.virtualHosts."cache.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        # proxyPass = "http://unix:${toString config.services.anubis.instances.atticd.settings.BIND}";
        proxyPass = "http://localhost:8060";
        proxyWebsockets = true;
      };
    };
  };
}
