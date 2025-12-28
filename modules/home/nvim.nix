{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Nixvim is being used for this
  programs.neovim = {
    enable = false;
    vimAlias = false;
  };
  xdg.mimeApps.defaultApplications = lib.mkIf config.xdg.mimeApps.enable {
    "text/markdown" = "nvim.desktop";
    "text/html" = "nvim.desktop";
    "text/xml" = "nvim.desktop";
    "text/plain" = "nvim.desktop";
    "text/x-shellscript" = "nvim.desktop";
  };

  home.packages = with pkgs; [
    inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default # import config from github:ahwxorg/nixvim-config
    mermaid-cli
    gnuplot
  ];
}
