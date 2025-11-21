{ config, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.funkwhale.overlay ];
  services = {
    funkwhale = {
      enable = true;
      hostname = "music.liv.town";
      defaultFromEmail = "notifications@liv.town";
      protocol = "https";
      forceSSL = true; # uncomment when LetsEncrypt needs to access "http:" in order to check domain
      api = {
        djangoSecretKeyFile = config.sops.secrets.funkwhaleDjangoSecret.path;
      };
    };
  };
}
