{ config, ... }:
{
  services.nextcloud = {                
    enable = true;                   
    hostName = "cloud.liv.town";
    https = true;

    virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };
  };
  
    
  security.acme = {
    acceptTerms = true;   
    certs = { 
      ${config.services.nextcloud.hostName}.email = "ahwx@ahwx.org"; 
    }; 
  };
}
