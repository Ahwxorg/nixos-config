{ ... }:
{
  imports =
    [ (import ./laptop.nix) ]
    ++ [ (import ./amdgpu.nix) ]
    ++ [ (import ./nvidia.nix) ]
    ++ [ (import ./server.nix) ]
    ++ [ (import ./router.nix) ]
    ++ [ (import ./desktop.nix) ]
    ++ [ (import ./wine.nix) ]
    ++ [ (import ./creative.nix) ]
    ++ [ (import ./gui.nix) ];
}
