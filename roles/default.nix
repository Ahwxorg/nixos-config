{ ... }:
{
  imports =
       [(import ./laptop.nix)]
    ++ [(import ./desktop.nix)]
    ++ [(import ./creative.nix)];
}
