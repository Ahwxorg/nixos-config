{ pkgs, lib, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.macAddress = "stable-ssid";
    };
    nameservers = [ "9.9.9.9" ];
    firewall = {
      enable = true;
    };
  };
  services = {
    avahi.enable = lib.mkDefault false;
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
      extraUpFlags = [
        # "--accept-dns=false"
        "--accept-routes"
      ];
    };
  };

  programs = {
    wireshark.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dig
    iftop
    inetutils
    ipcalc
    iperf
    nmap
    tcpdump
    traceroute
    tshark
  ];
}
