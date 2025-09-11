{ ... }:
{
  services = {
    fstrim.enable = true;
  };
  services.logind.settings.Login = {
    HandlePowerKey = "ignore"; # don’t shutdown when power button is short-pressed
  };

  # To prevent getting stuck at shutdown.
  # systemd.extraConfig = "DefaultTimeoutStopSec=10s"; # Deprecated now
}
