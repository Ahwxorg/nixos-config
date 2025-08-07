{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services = {
    forgejo = {
      enable = true;
      # database.type = "postgres";
      # Enable support for Git Large File Storage
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "code.liv.town";
          # You need to specify this to remove the port from URLs in the web UI.
          ROOT_URL = "https://${srv.DOMAIN}/";
          HTTP_PORT = 3050;
        };
        # You can temporarily allow registration to create an admin user.
        service.DISABLE_REGISTRATION = true;
        # Add support for actions, based on act: https://github.com/nektos/act
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };
        # TODO: run own email server that sends users emails!
        # You can send a test email from the web UI at:
        # Profile Picture > Site Administration > Configuration >  Mailer Configuration
        mailer = {
          ENABLED = true;
          SMTP_ADDR = "smtp.migadu.com";
          FROM = config.liv.variables.senderEmail;
          USER = config.liv.variables.senderEmail;
        };
      };
      secrets.mailer.PASSWD = config.sops.secrets.systemMailerPassword.path;
    };
    gitea-actions-runner = {
      package = pkgs.forgejo-runner;
      instances.code-liv-town = {
        enable = true;
        name = "forgejo-01";
        tokenFile = "${config.sops.secrets.forgejoWorkerSecret.path}";
        url = "https://code.liv.town";
        labels = [
          "node-22:docker://node:22-bookworm"
          "nixos-latest:docker://nixos/nix"
        ];
      };
    };
    anubis.instances.forgejo = {
      settings = {
        TARGET = "http://localhost:3050";
        BIND = ":3051";
        BIND_NETWORK = "tcp";
      };
    };
    nginx.virtualHosts."code.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost${toString config.services.anubis.instances.forgejo.settings.BIND}";
        proxyWebsockets = true;
      };
    };
  };
  # systemd.services.forgejo.preStart = let
  #   adminCmd = "${lib.getExe cfg.package} admin user";
  #   user = "liv";
  # in ''
  #   ${adminCmd} create --admin --email "liv@liv.town" --username ${user} --password "boopbeepboop123123123" || true
  # '';
}
