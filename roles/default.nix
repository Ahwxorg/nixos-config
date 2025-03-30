{ ... }:
{
  imports =
       [(import ./laptop.nix)]
    ++ [(import ./amdgpu.nix)]
    ++ [(import ./nvidia.nix)]
    ++ [(import ./desktop.nix)]
    ++ [(import ./wine.nix)]
    ++ [(import ./creative.nix)];
}
