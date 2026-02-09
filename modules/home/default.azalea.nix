{ ... }:
{
  imports =
    [ (import ./git.nix) ]
    ++ [ (import ./htop.nix) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./nvim.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./scripts/scripts.nix) ]
    ++ [ (import ./ssh.nix) ]
    ++ [ (import ./zsh.nix) ]
    ++ [ (import ./qutebrowser.nix) ]
    ++ [ (import ./tmux.nix) ];
}
