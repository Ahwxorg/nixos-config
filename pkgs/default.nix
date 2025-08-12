{ pkgs }:
{
  wikit = pkgs.callPackage ./wikit/default.nix { };
  nix-search-fzf = pkgs.callPackage ./nix-search-fzf/default.nix { };
}
