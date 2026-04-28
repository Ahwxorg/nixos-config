{
  self,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  services.envfs.enable = true;
}
