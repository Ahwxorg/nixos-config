{
  pkgs,
  inputs,
  config,
  username,
  host,
  ...
}:
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
      pcscd.enable = true;
      login.u2fAuth = false;
      greetd.u2fAuth = false;
      sudo.u2fAuth = true;
      swaylock.fprintAuth =
        if (host == "sakura") then
          true
        else if (host == "zinnia") then
          true
        else
          false;
      hyprlock.u2fAuth = false;
      hyprlock.fprintAuth =
        if (host == "sakura") then
          true
        else if (host == "zinnia") then
          true
        else
          false;
    };
  };

  services.fprintd.enable =
    if (host == "sakura") then
      true
    else if (host == "zinnia") then
      true
    else
      false;

  environment.systemPackages = with pkgs; [
    yubikey-manager
  ];
}
