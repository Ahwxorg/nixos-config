{ pkgs, ... }:
{
  services.avahi = {
    enable = false;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.enable = true;
  # environment.systemPackages = with pkgs; [
  # ];
}
