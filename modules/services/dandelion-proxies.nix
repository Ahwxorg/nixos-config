{
  services = {
    nginx.virtualHosts."photos.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        # proxyPass = "http://unix:${toString config.services.anubis.instances.librey.settings.BIND}";
        proxyPass = "http://172.16.10.185:2283";
        proxyWebsockets = true;
      };
      extraConfig = ''
        			client_body_buffer_size 1024k;
        			proxy_request_buffering off;
                                proxy_http_version 1.1;
                                proxy_redirect     off;
      '';
    };
  };
}
