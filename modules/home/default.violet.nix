{ ...}: {
  imports =
       [(import ./bat.nix)]                       # better cat command
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./nvim.nix)]                      # neovim editor
    ++ [(import ./packages.nix)]                  # other packages
    ++ [(import ./scripts/scripts.nix)]           # personal scripts
    ++ [(import ./zsh.nix)]                       # shell
    ++ [(import ./tmux.nix)];                     # terminal multiplexer
}
