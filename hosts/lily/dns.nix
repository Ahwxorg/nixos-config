{ lib, config, ... }:
{
  services = {
    dnsmasq = {
      enable = true;
      settings = {
        cache-size = 10000; # Specifies the size of the DNS query cache. It will store up to n cached DNS queries to improve response times for frequently accessed domains.
        server = [
          "9.9.9.9"
          "149.112.112.112"
        ];
        domain-needed = true; # Ensures that DNS queries are only forwarded for domains that are not found in the local configuration.
        bogus-priv = true; # Blocks DNS queries for private IP address ranges to prevent accidental exposure of private resources.
        no-resolv = true; # Prevents dnsmasq from using /etc/resolv.conf for DNS server configuration.

        # configure DHCP server; get leases by running: `cat /var/lib/dnsmasq/dnsmasq.leases`
        dhcp-range = [ "br-lan,172.16.10.50,172.16.10.254,24h" ];
        interface = "br-lan";
        dhcp-host = "172.16.10.1";

        # local sets the local domain name to "n". Combinded with expand-hosts = true, it will add a .local suffix to any local defined name when trying to resolve it.
        local = "/local/";
        domain = "local";
        expand-hosts = true;

        no-hosts = true; # Prevents the use of /etc/hosts. This ensures that the local hosts file is not used to override DNS resolution.
        address = "/booping.local/172.16.10.1";
      };
    };
  };
}
