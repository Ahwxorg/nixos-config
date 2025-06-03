{ pkgs, ... }:
{
  services.avahi = {
    enable = false;
    nssmdns4 = true;
    openFirewall = true;
  };
  # environment.systemPackages = with pkgs; [
  # ];
}
