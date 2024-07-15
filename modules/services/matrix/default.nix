{ pkgs, lib, config, ... }:
let
  fqdn = "quack.social";
  baseUrl = "https://${fqdn}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in {
  #age.secrets.matrix-synapse = {
  #    file = "../../../secrets/matrix-synapse.age";
  #};

  services = {
    # postgresql.enable = true;
    # postgresql.initialScript = pkgs.writeText "synapse-init.sql" ''
    #   CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
    #   CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
    #     TEMPLATE template0
    #     LC_COLLATE = "C"
    #     LC_CTYPE = "C";
    # '';

    nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      virtualHosts = {
        # If the A and AAAA DNS records on example.org do not point on the same host as the
        # records for myhostname.example.org, you can easily move the /.well-known
        # virtualHost section of the code to the host that is serving example.org, while
        # the rest stays on myhostname.example.org with no other changes required.
        # This pattern also allows to seamlessly move the homeserver from
        # myhostname.example.org to myotherhost.example.org by only changing the
        # /.well-known redirection target.
        "${fqdn}" = {
          enableACME = true;
          forceSSL = true;
          # This section is not needed if the server_name of matrix-synapse is equal to
          # the domain (i.e. example.org from @foo:example.org) and the federation port
          # is 8448.
          # Further reference can be found in the docs about delegation under
          # https://element-hq.github.io/synapse/latest/delegate.html
          locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
          # This is usually needed for homeserver discovery (from e.g. other Matrix clients).
          # Further reference can be found in the upstream docs at
          # https://spec.matrix.org/latest/client-server-api/#getwell-knownmatrixclient
          locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
          # It's also possible to do a redirect here or something else, this vhost is not
          # needed for Matrix. It's recommended though to *not put* element
          # here, see also the section about Element.
          locations."/".extraConfig = ''
            return 404;
          '';
          # Forward all Matrix API calls to the synapse Matrix homeserver. A trailing slash
          # *must not* be used here.
          locations."/_matrix".proxyPass = "http://[::1]:8008";
          # Forward requests for e.g. SSO and password-resets.
          locations."/_synapse/client".proxyPass = "http://[::1]:8008";
          locations."wp-login.php".return = "301 https://hil-speed.hetzner.com/10GB.bin";
        };
      };
    };

    matrix-synapse = {
      enable = true;
      settings = {
        # database.name = "psycopg2";
        # database.args = {
        #   user = "matrix-synapse";
        #   password = "synapse";
        # };
        server_name = "${fqdn}";
        public_baseurl = "https://${fqdn}";
        enable_registration = false;
        #registration_shared_secret = config.age.secrets.matrix-synapse;
        #macaroon_secret_key = config.age.secrets.matrix-synapse;
        listeners = [
          { port = 8008;
            bind_addresses = [ "::1" ];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [ {
              names = [ "client" "federation" ];
              compress = true;
            } ];
          }
        ];
      };
    };
  };
}
