{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        hplipWithPlugin
      ];
    };

    # avahi = {
    #   enable = false;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };

    ipp-usb.enable = true;
  };
}
