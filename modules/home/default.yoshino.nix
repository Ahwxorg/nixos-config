{ ...}: {
  imports =
       [(import ./git.nix)]                       # version control
    ++ [(import ./swaync/default.nix)]            # notification panel
    ++ [(import ./fonts.nix)]                     # fonts
    ++ [(import ./hyprland)]                      # window manager
    ++ [(import ./kitty.nix)]                     # terminal
    ++ [(import ./mako.nix)]                      # notification deamon
    ++ [(import ./nvim.nix)]                      # neovim editor
    ++ [(import ./zathura.nix)]                   # neovim editor
    ++ [(import ./packages.yoshino.nix)]                  # other packages
    ++ [(import ./scripts/scripts.nix)]           # personal scripts
    ++ [(import ./swaylock.nix)]                  # lock screen
    ++ [(import ./waybar)]                        # status bar
    ++ [(import ./wofi.nix)]                      # launcher
    ++ [(import ./zsh.nix)]                       # shell
    ++ [(import ./tmux.nix)];                     # terminal multiplexer
}
