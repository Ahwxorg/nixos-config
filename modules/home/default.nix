{ ... }:
{
  imports =
    [ (import ./git.nix) ]
    ++ [ (import ./swaync/default.nix) ]
    ++ [ (import ./fonts.nix) ]
    ++ [ (import ./hyprland) ]
    ++ [ (import ./hyprlock) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./nvim.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./scripts/scripts.nix) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./zsh.nix) ]
    ++ [ (import ./qutebrowser.nix) ]
    ++ [ (import ./tmux.nix) ];
}
