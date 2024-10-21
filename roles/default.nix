{ ... }:
{
  imports =
       [(import ./laptop.nix)]
    ++ [(import ./desktop.nix)];
}
