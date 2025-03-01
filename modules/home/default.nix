{ ... }: {
  imports =
       [(import ./git.nix)]
    ++ [(import ./swaync/default.nix)]
    ++ [(import ./fonts.nix)]
    ++ [(import ./hyprland)]
    ++ [(import ./kitty.nix)]
    ++ [(import ./nvim.nix)]
    ++ [(import ./zathura.nix)]
    ++ [(import ./packages.nix)]
    ++ [(import ./scripts/scripts.nix)]
    ++ [(import ./swaylock.nix)]
    ++ [(import ./waybar)]
    ++ [(import ./zsh.nix)]
    ++ [(import ./tmux.nix)];
}
