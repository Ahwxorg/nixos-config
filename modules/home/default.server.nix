{ ...}: {
  imports =
       [(import ./git.nix)]                       # version control
    ++ [(import ./nvim.nix)]                      # neovim editor
    ++ [(import ./packages.server.nix)]           # other packages
    ++ [(import ./scripts/scripts.nix)]           # personal scripts
    ++ [(import ./zsh.nix)]                       # shell
    ++ [(import ./tmux.nix)];                     # terminal multiplexer
}
