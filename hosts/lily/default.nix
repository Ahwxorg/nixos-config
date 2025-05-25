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

    # <100 is trusted; =>100 is untrusted.
    vlans = {
      lan = {
        id = 1;
        interface = "lan1";
      };
      servers = {
        id = 10;
        interface = "lan1";
      };
      management = {
        id = 21;
        interface = "lan1";
      };
      iot = {
        id = 100;
        interface = "lan1";
      };
      guest = {
        id = 110;
        interface = "lan1";
      };
    };
  };

  services = {
    udev.extraRules = ''
      SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:47:67:6e", ATTR{type}=="1", NAME="wan0"
      SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:47:67:6f", ATTR{type}=="1", NAME="lan0"
      SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:63:0f:80", ATTR{type}=="1", NAME="lan1"
      SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:63:0f:81", ATTR{type}=="1", NAME="lan2"
    '';
    dhcpd4 = {
      enable = true;
      interfaces = [
        "lan"
        "servers"
        "management"
        "iot"
        "guest"
      ];
      extraConfig = ''
        option domain-name-servers 9.9.9.9, 149.112.112.112;
        option subnet-mask 255.255.255.0;

        subnet 172.16.1.0 netmask 255.255.255.0 {
          option broadcast-address 172.16.1.255;
          option routers 172.16.1.1;
          interface lan;
          range 172.16.1.50 172.16.1.254;
        }
        subnet 172.16.10.0 netmask 255.255.255.0 {
          option broadcast-address 172.16.10.255;
          option routers 172.16.10.1;
          interface servers;
          range 172.16.10.50 172.16.10.254;
        }
        subnet 172.16.21.0 netmask 255.255.255.0 {
          option broadcast-address 172.16.21.255;
          option routers 172.16.21.1;
          interface management;
          range 172.16.21.50 172.16.21.254;
        }
        subnet 172.16.100.0 netmask 255.255.255.0 {
          option broadcast-address 172.16.100.255;
          option routers 172.16.100.1;
          interface iot;
          range 172.16.100.50 172.16.100.254;
        }
        subnet 172.16.110.0 netmask 255.255.255.0 {
          option broadcast-address 172.16.110.255;
          option routers 172.16.110.1;
          interface guest;
          range 172.16.110.50 172.16.110.254;
        }
      '';
    };
    avahi = {
      enable = true;
      reflector = true;
      interfaces = [
        "lan"
        "iot"
      ];
    };
  };

  networking.hostName = "lily";

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    kitty.terminfo
    tcpdump
    dnsutils
    bind
    ethtool
  ];
}
