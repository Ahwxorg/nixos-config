{ inputs, ... }:
{
  imports =
    [ (import ./hyprland.nix) ]
    ++ [ (import ./config.nix) ]
    ++ [ (import ./scripts.nix) ]
    ++ [ (import ./variables.nix) ]
    ++ [ (import ./../hyprsunset.nix) ]
    ++ [ (import ./../hyprlock/default.nix) ]
    ++ [ inputs.hyprland.homeManagerModules.default ];
}
