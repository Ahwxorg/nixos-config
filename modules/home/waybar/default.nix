{ config, lib, pkgs, user, ... }:

{
  imports =
    [(import ./scripts.nix)];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
  };
}

