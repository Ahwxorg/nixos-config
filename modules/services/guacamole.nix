{ config, ... }:
{
  services = {
    guacamole-server = {
      enable = true;
      host = "127.0.0.1";
      port = 4822;
      userMappingXml = ./guacamole-user-mapping.xml;
    };
    guacamole-client = {
      enable = true;
      enableWebserver = true;
      settings = {
        guacd-port = 4822;
        guacd-hostname = "localhost";
      };
    };
    anubis.instances.guacamole = {
      settings = {
        TARGET = "http://localhost:4822";
        BIND = ":4883";
        BIND_NETWORK = "tcp";
      };
    };
    nginx.virtualHosts."remote.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost${toString config.services.anubis.instances.guacamole.settings.BIND}";
        proxyWebsockets = true;
      };
    };
  };
}
