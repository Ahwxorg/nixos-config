{ ... }:
{
  imports =
    [ (import ./git.nix) ]
    ++ [ (import ./swaync/default.nix) ]
    ++ [ (import ./sway/default.nix) ]
    ++ [ (import ./fonts.nix) ]
    ++ [ (import ./hyprland) ]
    ++ [ (import ./hyprlock) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./foot.nix) ]
    ++ [ (import ./nvim.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./scripts/scripts.nix) ]
    ++ [ (import ./spotify.nix) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./zsh.nix) ]
    ++ [ (import ./qutebrowser.nix) ]
    ++ [ (import ./tmux.nix) ];
}
