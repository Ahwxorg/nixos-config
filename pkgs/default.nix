{ pkgs }:
{
  createScript = pkgs.callPackage ./createScript/default.nix { };
  nix-search-fzf = pkgs.callPackage ./nix-search-fzf/default.nix { };
  nixos-centered-plymouth = pkgs.callPackage ./nixos-centered-plymouth/default.nix { };
}
