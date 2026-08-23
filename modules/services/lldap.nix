{ config, ... }:
{
  services = {
    lldap = {
      enable = true;
      settings = {
        http_url = "https://ldap.liv.town";
        ldap_base_dn = "dc=livtown,dc=xyz";
        # key_file = config.sops.secrets.lldapPrivateKey.path;
        ldap_host = "127.0.0.1";
        http_host = "127.0.0.1";
      };
      environment = {
        LLDAP_JWT_SECRET_FILE = config.sops.secrets.lldapJwtSecret.path;
        LLDAP_LDAP_USER_PASS_FILE = config.sops.secrets.lldapUserPass.path;
      };
    };
    nginx.virtualHosts = {
      "ldap.liv.town" = {
        forceSSL = true;
        sslCertificate = "/var/lib/acme/liv.town/cert.pem";
        sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
        locations."/" = {
          proxyPass = "http://localhost:17170";
          proxyWebsockets = true;
        };
      };
    };
  };
  # systemd.services.lldap.serviceConfig.SupplementaryGroups = [ "lldap-secrets" ];
}
