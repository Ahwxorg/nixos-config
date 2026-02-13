{ ... }:
{
  imports =
    [ (import ./git.nix) ]
    ++ [ (import ./fonts.nix) ]
    ++ [ (import ./htop.nix) ]
    ++ [ (import ./iamb.nix) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./nvim.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./scripts/scripts.nix) ]
    ++ [ (import ./ssh.nix) ]
    ++ [ (import ./skhd.nix) ]
    ++ [ (import ./sketchybar/default.nix) ]
    ++ [ (import ./jankyborders.nix) ]
    ++ [ (import ./zsh.nix) ]
    ++ [ (import ./qutebrowser.nix) ]
    ++ [ (import ./tmux.nix) ];
}
