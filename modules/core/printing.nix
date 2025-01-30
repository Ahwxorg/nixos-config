{ pkgs, ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    hplip
    hplipWithPlugin
  ];
}
