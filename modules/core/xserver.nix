{ username, ... }: 
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
  };

  # To prevent getting stuck at shutdown - this is not Xorg related, but I like to blame Xorg for all of my life issues.
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
