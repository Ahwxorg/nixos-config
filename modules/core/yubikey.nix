{ pkgs, inputs, config, username, host, ...}:

{
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
  security.pam = {
    u2f = {
      enable = true;
      settings.cue = true;
      control = "sufficient";
    };

    services = {
      login.u2fAuth = true;
      greetd.u2fAuth = true;
      sudo.u2fAuth = true;
      hyprlock.u2fAuth = true;
      # pam.services.swaylock = {}; # Already enabled
    };
  };

  services = {
    fprintd.enable = if (host == "sakura") then true else false;
    swaylock.fprintAuth = if (host == "sakura") then true else false;
    hyprlock.fprintAuth = if (host == "sakura") then true else false;
  };

  environment.systemPackages = with pkgs; [
    yubikey-manager
  ];
}
