{ pkgs, lib, ... }:

{
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi;
    mongodbPackage = pkgs.mongodb-7_0;
  };
  # services.nginx = {
  #   enable = true;
  #   recommendedProxySettings = true;

  #   virtualHosts."unifi.local" = {
  #     forceSSL = true;
  #     useACMEHost = "unifi.local";
  #     locations."/" = {
  #       proxyPass = "https://127.0.0.1:8443";
  #       proxyWebsockets = true;
  #     };
  #   };
  # };
  #   virtualisation.oci-containers.containers."unifi" = {
  #     image = "lscr.io/linuxserver/unifi-network-application:latest";
  #     autoStart = true;
  #     environmentFiles = [ /run/unifi/container-vars.env ];
  #     volumes = [
  #       "/etc/localtime:/etc/localtime:ro"
  #       "/run/unifi/data:/config"
  #     ];
  #     ports = [
  #       "8443:8443" # web admin UI
  #       "3478:3478/udp" # STUN
  #       "10001:10001/udp" # AP discovery
  #       "8080:8080" # device communication
  #       "6789:6789/udp" # mobile throughput test (assumption: wifiman)
  #       "5514:5514/udp" # remote syslog (optional)
  #     ];
  #     dependsOn = [
  #       "unifi-mongo"
  #     ];
  #     log-driver = "journald";
  #   };
  #   virtualisation.oci-containers.containers."unifi-mongo" = {
  #     image = "mongo:latest";
  #     autoStart = true;
  #     volumes = [
  #       "/etc/localtime:/etc/localtime:ro"
  #       "/run/unifi/mongo/db:/data/db"
  #       "/run/unifi/mongo/init-mongo.js:/docker-entrypoint-initdb.d/init-mongo.js:ro"
  #     ];
  #     log-driver = "journald";
  #   };

  networking.firewall.interfaces."lan0" = {
    allowedTCPPorts = [
      8443 # web admin UI
      8080 # device communication
    ];
    allowedUDPPorts = [
      6789 # mobile throughput test (assumption: wifiman)
      5514 # remote syslog (optional)
      3478 # STUN
      10001 # AP discovery
    ];
  };
}
