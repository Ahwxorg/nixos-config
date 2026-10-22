{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
  ) pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.server.nix
    ./../../modules/services/home-assistant.nix
    ./../../modules/services/monitoring.nix
    ./../../modules/services/smart-monitoring.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/nfs.nix
    ./../../modules/services/hd-idle.nix

    ./../../modules/services/invidious.nix
    ./../../modules/services/binternet-proxy.nix
    ./../../modules/services/email.nix
    ./../../modules/services/forgejo.nix
    ./../../modules/services/gokapi.nix
    ./../../modules/services/immich-proxy.nix
    ./../../modules/services/matrix/default.nix
    ./../../modules/services/mumble.nix
    ./../../modules/services/ntfy.nix
    ./../../modules/services/nginx.nix
    ./../../modules/services/prosody.nix
    ./../../modules/services/pollaris-proxy.nix
    ./../../modules/services/radicale.nix
    ./../../modules/services/sharkey-proxy.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/uptime-kuma.nix
    ./../../modules/services/vaultwarden.nix
    ./../../modules/services/nextcloud.nix
    ./../../modules/services/tinyauth.nix
    ./../../modules/services/lldap.nix
    ./../../modules/services/miniflux.nix
    ./../../modules/services/navidrome.nix
    ./../../modules/services/grafana.nix
    ./../../modules/services/jellyfin.nix
    ./../../modules/services/ircd.nix
    ./../../modules/services/panel-proxy.nix
    ./../../modules/services/iocaine.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services = {
    vnstat.enable = true;
    smartd = {
      enable = true;
      autodetect = true;
    };
    zfs = {
      autoScrub.enable = true;
      autoScrub.interval = "weekly";
      trim.enable = true;
    };
  };

  networking = {
    hostName = "flora";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        80
        443
        25565
        25567
        5201
        5601
        6697
      ];
      allowedUDPPorts = [
        5201
      ];
    };
  };

  boot.kernelPackages = latestKernelPackage; # or; use pkgs.linuxPackages_latest but that doesn't work for ZFS half of the time

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  environment.systemPackages = [
    pkgs.kitty
    pkgs.foot
    pkgs.zpool-iostat-viz
  ];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.11";
}
