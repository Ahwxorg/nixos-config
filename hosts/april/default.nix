{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/services/tailscale.nix
    ./../../modules/services/mpd.nix
  ];

  liv = {
    laptop.enable = true;
    gui.enable = true;
    desktop.enable = false;
    creative.enable = false;
    amdgpu.enable = false;
  };
}
