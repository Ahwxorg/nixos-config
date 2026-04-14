{
  pkgs,
  lib,
  config,
  host,
  username,
  ...
}:
let
  fqdn = "liv.town";
  baseUrl = "https://${fqdn}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    # add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Proto https;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $remote_addr;
  '';
  extraProxyConfig = ''
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Proto https;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $remote_addr;
  '';
  extraIpConfig = "200 $remote_addr";
  baseRepo = "ssh://liv@dandelion:9123/spinners/rootvol/backups/${host}";
in
{
  services = {
    nginx = {
      virtualHosts = {
        "${fqdn}" = {
          # enableACME = true;
          forceSSL = true;
          sslCertificate = "/var/lib/acme/liv.town/cert.pem";
          sslCertificateKey = "/var/lib/acme/liv.town/key.pem";

          locations = {
            "= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
            "= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
            "/".proxyPass = "http://localhost:4321"; # index should be proxied to Docker container
            "/ip".return = extraIpConfig;
            "/_matrix".proxyPass = "http://[::1]:8008";
            "/_matrix".extraConfig = extraProxyConfig;
            # Forward requests for e.g. SSO and password-resets.
            "/_synapse/client".proxyPass = "http://[::1]:8008";
            "/_synapse/client".extraConfig = extraProxyConfig;
            "wp-login.php".return = "301 https://hil-speed.hetzner.com/10GB.bin";
          };
        };
        "api.${fqdn}" = {
          forceSSL = true;
          sslCertificate = "/var/lib/acme/liv.town/cert.pem";
          sslCertificateKey = "/var/lib/acme/liv.town/key.pem";

          locations = {
            "/".proxyPass = "http://localhost:3334";
            "/".extraConfig = extraProxyConfig;
            "wp-login.php".return = "301 https://hil-speed.hetzner.com/10GB.bin";
          };
        };
      };
    };

    postgresql = {
      enable = true;
      initialScript = pkgs.writeText "synapse-init.sql" ''
        CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
        CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
          TEMPLATE template0
          LC_COLLATE = "C"
          LC_CTYPE = "C";
      '';
    };

    matrix-synapse = {
      enable = true;
      settings = {
        database.name = "psycopg2";
        database.args = {
          user = "matrix-synapse";
          password = "synapse";
        };
        server_name = "${fqdn}";
        public_baseurl = "https://${fqdn}";
        enable_registration = false;
        registration_shared_secret_path = config.sops.secrets.matrixRegistrationSecret.path;
        listeners = [
          {
            port = 8008;
            bind_addresses = [
              "127.0.0.1"
              "::1"
            ];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                names = [
                  "client"
                  "federation"
                ];
                compress = true;
              }
            ];
          }
        ];
        app_service_config_files = [
          # The registration file is automatically generated after starting the
          # appservice for the first time.
          # cp /var/lib/mautrix-whatsapp/whatsapp-registration.yaml \
          #   /var/lib/matrix-synapse/
          # chown matrix-synapse:matrix-synapse \
          #   /var/lib/matrix-synapse/whatsapp-registration.yaml
          # "/var/lib/matrix-synapse/whatsapp-registration.yaml"

          # The registration file is automatically generated after starting the
          # appservice for the first time.
          # cp /var/lib/mautrix-signal/signal-registration.yaml \
          #   /var/lib/matrix-synapse/
          # chown matrix-synapse:matrix-synapse \
          #   /var/lib/matrix-synapse/signal-registration.yaml
          # "/var/lib/matrix-synapse/signal-registration.yaml"

        ];
      };
    };

    mautrix-whatsapp = {
      enable = true;
      settings = {
        appservice = {
          ephemeral_events = true;
          id = "whatsapp";
        };
        homeserver = {
          address = "http://localhost:8008";
        };
        database = {
          type = "sqlite3";
          uri = "/var/lib/mautrix-whatsapp/mautrix-whatsapp.db";
        };
        encryption = {
          allow = true;
          default = true;
          require = true;
          pickle_key = whatsapp_pickle_key;
        };
        bridge = {
          history_sync = {
            request_full_sync = true;
          };
          mute_bridging = true;
          permissions = {
            "@liv:liv.town" = "admin";
            "@frengel:liv.town" = "user";
          };
          private_chat_portal_meta = true;
          provisioning = {
            shared_secret = "disable";
          };
        };
      };
    };
    mautrix-signal = {
      enable = true;
      settings = {
        appservice = {
          ephemeral_events = true;
          id = "signal";
        };
        homeserver = {
          address = "http://localhost:8008";
        };
        database = {
          type = "sqlite3";
          uri = "/var/lib/mautrix-signal/mautrix-signal.db";
        };
        encryption = {
          allow = true;
          default = true;
          require = true;
          pickle_key = signal_pickle_key;
        };
        bridge = {
          username_template = "signal_b_{{.}}";
          history_sync = {
            request_full_sync = true;
          };
          mute_bridging = true;
          permissions = {
            "@liv:liv.town" = "admin";
            "@frengel:liv.town" = "user";
          };
          private_chat_portal_meta = true;
          provisioning = {
            shared_secret = "disable";
          };
        };
      };
    };
    borgbackup.jobs."violet-matrix" = {
      paths = [
        "/var/lib/matrix-synapse"
        "/var/lib/mautrix-signal"
        "/var/lib/mautrix-whatsapp"
      ];
      repo = "${baseRepo}/var-matrix";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = [ "3:00" ];
      preHook = ''
        systemctl stop matrix-synapse mautrix-signal mautrix-whatsapp
      '';
      postHook = ''
        systemctl start matrix-synapse mautrix-signal mautrix-whatsapp
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (matrix) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (matrix) completed succesfully with exit status $exitStatus"
        fi
      '';
      user = "root";
      extraCreateArgs = [
        "--stats"
      ];
      environment = {
        BORG_RSH = "ssh -p 9123 -i /home/${username}/.ssh/id_ed25519";
      };
    };
    borgbackup.jobs."violet-postgres" = {
      paths = [
        "/var/lib/postgresql"
      ];
      repo = "${baseRepo}/var-postgresql";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = [ "3:30" ];
      preHook = ''
        systemctl stop matrix-synapse mautrix-signal mautrix-whatsapp postgresql
      '';
      postHook = ''
        systemctl start matrix-synapse mautrix-signal mautrix-whatsapp postgresql
        if [ $exitStatus -eq 2 ]; then
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (postgresql) failed with errors"
        else
          ${pkgs.ntfy-sh}/bin/ntfy send https://notify.liv.town/${host} "borgbackup: ${host} backup (postgresql) completed succesfully with exit status $exitStatus"
        fi
      '';
      user = "root";
      extraCreateArgs = [
        "--stats"
      ];
      environment = {
        BORG_RSH = "ssh -p 9123 -i /home/${username}/.ssh/id_ed25519";
      };
    };
  };
}
