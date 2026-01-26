{ pkgs, ... }:
{
  services.smartd = {
    enable = true;
    autodetect = true;
  };
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
}
