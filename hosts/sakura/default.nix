{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/core/virtualization.nix
    ./../../modules/services/tailscale.nix
    ./../../modules/services/mpd.nix
    ./../../modules/services/smart-monitoring.nix
    ./../../modules/services/ivpn.nix
    ./../../modules/home/steam.nix
    ./../../modules/services/ollama.nix
    # ./../../modules/services/automount.nix
  ];

  # install some system-utilities; set hosts to be editable by the user.
  environment = {
    systemPackages = [
      pkgs.fwupd
      pkgs.fw-ectool
      pkgs.monero-gui
      pkgs.remmina
      pkgs.spotify
    ];
  };

  liv = {
    laptop.enable = true;
    desktop.enable = false;
    creative.enable = true;
    # amdgpu.enable = true;
    gui.enable = true;
    wine.enable = true;
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';
}
