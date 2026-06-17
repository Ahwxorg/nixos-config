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
    settings.trusted-users = [
      "root"
      "@wheel"
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  services.envfs.enable = true;
}
