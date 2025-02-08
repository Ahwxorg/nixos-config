{ ... }:
{
  services = {
    jitsi-meet = {
      enable = true;
      hostName = "meet.liv.town";
      prosody.lockdown = true;
      config = {
        enableWelcomePage = false;
        prejoinPageEnabled = true;
      };
      interfaceConfig = {
        SHOW_JITSI_WATERMARK = false;
        SHOW_WATERMARK_FOR_GUESTS = false;
      };
    };
    nginx.virtualHosts."meet.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://localhost:8080";
        proxyWebsockets = true;
      };
    };
  };
}
