{ pkgs, config, ... }:
{
  services = {
    tinyauth = {
      enable = true;
      package = pkgs.tinyauth;
      environmentFile = config.sops.secrets.tinyauthEnvironment.path;

      settings = {
        APPURL = "https://authenticate.liv.town";
        SERVER_PORT = 3030;
        AUTH_LOGINMAXRETRIES = 3;
        AUTH_LOGINTIMEOUT = 3600;
        SERVER_ADDRESS = "0.0.0.0";

        # app specific
        # where [NAME] is: "https://[NAME].example.com/"
        # APPS_[NAME]_OAUTH_GROUPS
        # APPS_SCROBBLE_OAUTH_GROUPS = "tinyauth_scrobble_user";
      };
    };

    nginx.virtualHosts = {
      "authenticate.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/" = {
          proxyPass = "http://localhost:3030";
          proxyWebsockets = true;
        };
      };
    };
  };

  systemd.services.tinyauth.after = [ "lldap.service" ];
}
