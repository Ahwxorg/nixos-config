{
  # services.prosody = {
  #   enable = false;
  #   user = "acme";
  #   modules = {
  #     welcome = true;
  #     websocket = true;
  #     watchregistrations = true;
  #   };
  #   admins = [ "liv@liv.town" ];
  #   allowRegistration = false;
  #   ssl.cert = "/var/lib/acme/liv.town/cert.pem";
  #   ssl.key = "/var/lib/acme/liv.town/key.pem";
  #   virtualHosts."liv.town" = {
  #     enabled = true;
  #     domain = "liv.town";
  #     ssl.cert = "/var/lib/acme/liv.town/fullchain.pem";
  #     ssl.key = "/var/lib/acme/liv.town/key.pem";
  #   };
  #   muc = [
  #     {
  #       domain = "conference.liv.town";
  #     }
  #   ];
  #   uploadHttp = {
  #     domain = "upload.liv.town";
  #   };
  # };
}
