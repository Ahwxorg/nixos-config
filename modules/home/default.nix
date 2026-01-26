{ ... }:
{
  imports =
    [ (import ./git.nix) ]
    ++ [ (import ./swaync/default.nix) ]
    ++ [ (import ./sway/default.nix) ]
    ++ [ (import ./fonts.nix) ]
    ++ [ (import ./htop.nix) ]
    ++ [ (import ./hyprland) ]
    ++ [ (import ./hyprlock) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./kanshi.nix) ]
    ++ [ (import ./foot.nix) ]
    ++ [ (import ./nextcloud.nix) ]
    ++ [ (import ./nvim.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./scripts/scripts.nix) ]
    ++ [ (import ./spotify.nix) ]
    ++ [ (import ./ssh.nix) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./zsh.nix) ]
    ++ [ (import ./qutebrowser.nix) ]
    ++ [ (import ./xdg.nix) ]
    ++ [ (import ./tmux.nix) ];
}
