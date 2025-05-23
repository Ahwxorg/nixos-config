{
  lib,
  pkgs,
  config,
  ...
}:
let
  externalInterface = "wan0";
  # networks = config.homelab.networks.local;
  # internalInterfaces = lib.mapAttrsToList (_: val: val.interface) networks;
  # internalIPs = lib.mapAttrsToList (
  #   _: val: lib.strings.removeSuffix ".1" val.cidr + ".0/24"
  # ) networks;
in
{
  imports = [
    ./hardware-configuration.nix
    ./variables.nix
    ./dns.nix
    ./wireguard.nix
    ./../../modules/core/default.router.nix
    ./../../modules/services/lily.nix
  ];

  liv = {
    server.enable = true;
    router.enable = true;
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
    kernel = {
      sysctl = {
        # Forward both IPv4 and IPv6 on all interfaces
        "net.ipv4.conf.all.forwarding" = true;
        "net.ipv6.conf.all.forwarding" = false;

        # By default, do not automatically configure any IPv6 addresses.
        # "net.ipv6.conf.all.accept_ra" = 0;
        # "net.ipv6.conf.all.autoconf" = 0;
        # "net.ipv6.conf.all.use_tempaddr" = 0;

        # Allow IPv6 autoconfiguration and tempory address use on WAN.
        "net.ipv6.conf.${externalInterface}.accept_ra" = 2;
        "net.ipv6.conf.${externalInterface}.autoconf" = 1;
      };
    };
  };

  networking = {
    firewall = {
      enable = false;
      allowPing = true;

      # allow ssh on *all* interfaces, even wan.
      allowedTCPPorts = lib.mkForce [ 22 ];
      allowedUDPPorts = lib.mkForce [ 22 ];

      # interface-specific rules
      interfaces = {
        "lan0" = {
          allowedTCPPorts = [
            22
            53
          ];
          allowedUDPPorts = [
            22
            53
          ];
        };
      };
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:47:67:6e", ATTR{type}=="1", NAME="wan0"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:47:67:6f", ATTR{type}=="1", NAME="lan0"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:63:0f:80", ATTR{type}=="1", NAME="lan1"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:63:0f:81", ATTR{type}=="1", NAME="lan2"
  '';

  networking.hostName = "lily";

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    kitty.terminfo
    tcpdump
    dnsutils
  ];
}
