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
  commonDhcpOptions = [
    {
      name = "domain-name-servers";
      data = "9.9.9.9";
    }
    {
      name = "time-servers";
      data = "172.16.1.1";
    }
    {
      name = "domain-name";
      data = "beeping.local";
    }
    {
      name = "domain-search";
      data = "beeping.local";
    }
  ];
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

  # label network interfaces
  services.udev.extraRules = ''
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:47:67:6e", ATTR{type}=="1", NAME="wan0"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:47:67:6f", ATTR{type}=="1", NAME="lan0"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:63:0f:80", ATTR{type}=="1", NAME="lan1"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:25:90:63:0f:81", ATTR{type}=="1", NAME="lan2"
  '';

  networking = {
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
    interfaces = {
      wan0.useDHCP = true;
      lan0.useDHCP = false;
      lan1.useDHCP = false;
      lan2.useDHCP = false;
    };

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
    kea.dhcp4 = {
      enable = true;
      settings = {
        lease-database = {
          name = "/var/lib/kea/dhcp4.leases";
          persist = true;
          type = "memfile";
        };
        interfaces-config = {
          interfaces = [
            "lan"
            "servers"
            "management"
            "iot"
            "guest"
          ];
        };
        option-data = [
          {
            name = "domain-name-servers";
            data = "";
            always-send = true;
          }
          {
            name = "routers";
            data = "";
          }
          {
            name = "domain-name";
            data = "beeping.local";
          }
        ];

        rebind-timer = 2000;
        renew-timer = 1000;
        valid-lifetime = 43200;

        # option domain-name-servers 9.9.9.9, 149.112.112.112;
        # TODO: these should be dynamically generated based on ${config.networking.vlans}
        subnet4 = [
          ({
            id = 1;
            interface = "lan";
            subnet = "172.16.1.0/24";
            pools = [ { pool = "172.16.1.50 - 172.16.1.254"; } ];
            option-data = [
              {
                name = "routers";
                data = "172.16.1.1";
              }
            ] ++ commonDhcpOptions;
          })
          ({
            id = 10;
            interface = "servers";
            subnet = "172.16.10.0/24";
            pools = [ { pool = "172.16.10.50 - 172.16.10.254"; } ];
            option-data = [
              {
                name = "routers";
                data = "172.16.10.1";
              }
            ] ++ commonDhcpOptions;
          })
          ({
            id = 21;
            interface = "management";
            subnet = "172.16.21.0/24";
            pools = [ { pool = "172.16.21.50 - 172.16.21.254"; } ];
            option-data = [
              {
                name = "routers";
                data = "172.16.21.1";
              }
            ] ++ commonDhcpOptions;
          })
          ({
            id = 100;
            interface = "iot";
            subnet = "172.16.100.0/24";
            pools = [ { pool = "172.16.100.50 - 172.16.100.254"; } ];
            option-data = [
              {
                name = "routers";
                data = "172.16.100.1";
              }
            ] ++ commonDhcpOptions;
          })
          ({
            id = 110;
            interface = "guest";
            subnet = "172.16.110.0/24";
            pools = [ { pool = "172.16.110.50 - 172.16.110.254"; } ];
            option-data = [
              {
                name = "routers";
                data = "172.16.110.1";
              }
            ] ++ commonDhcpOptions;
          })
        ];
      };
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
