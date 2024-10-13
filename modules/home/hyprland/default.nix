{ inputs, ... }: 
{
  imports = [ (import ./hyprland.nix) ]
    ++ [ (import ./config.nix) ]
    ++ [ (import ./scripts.nix) ]
    ++ [ (import ./variables.nix) ]
    ++ [ (import ./hyprlock.nix) ]
    ++ [ inputs.hyprland.homeManagerModules.default ];
}
