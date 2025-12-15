{
  config,
  lib,
  pkgs,
  inputs,
  host,
  ...
}:
let
  ipv6 = false; # We don't have IPv6 yet sadly
  blocklist_base = builtins.readFile inputs.oisd;
  extraBlocklist = '''';
  blocklist_txt = pkgs.writeText "blocklist.txt" ''
    ${extraBlocklist}
    ${blocklist_base}
  '';
in
{
  services.dnscrypt-proxy = {
    enable = true;
    # See https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "sha256-QIpM9e7dye+EDO9rvlhSbDVLtmcgw8aLtg0DncPHK2s="; # See https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        cache_file = "/var/lib/dnscrypt/public-resolvers.md";
      };

      # Use servers reachable over IPv6 -- Do not enable if you don't have IPv6 connectivity
      ipv6_servers = ipv6;
      block_ipv6 = !(ipv6);

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      # If you want, choose a specific set of servers that come from your sources.
      # Here it's from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # If you don't specify any, dnscrypt-proxy will automatically rank servers
      # that match your criteria and choose the best one.
      # server_names = [ ... ];
      blocked_names.blocked_names_file = blocklist_txt;
    };
  };

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = "dnscrypt-proxy";

  networking.networkmanager.dns = "none"; # set system DNS to not get random records from DHCP
  programs.captive-browser = {
    enable = true; # enable dedicated Chromium instance to deal with captive portals without messing with system DNS settings
    interface = if (host == "sakura") then "wlp1s0" else "null"; # TODO: add hostnames for more devices
  };
}
