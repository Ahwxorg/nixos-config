{ pkgs, ... }:
{
  programs.neovim = {
    enable = false;
    vimAlias = false;
  };
}
