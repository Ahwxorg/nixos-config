{ ... }:
{
  services = {
    fstrim.enable = true;
  };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  # To prevent getting stuck at shutdown.
  # systemd.extraConfig = "DefaultTimeoutStopSec=10s"; # Deprecated now
}
