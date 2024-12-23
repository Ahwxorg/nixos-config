{ ... }: {
  imports =
       [(import ./git.nix)]
    ++ [(import ./swaync/default.nix)]
    ++ [(import ./fonts.nix)]
    ++ [(import ./hyprland)]
    ++ [(import ./sway)]
    ++ [(import ./kitty.nix)]
    ++ [(import ./mako.nix)]
    ++ [(import ./nvim.nix)]
    ++ [(import ./zathura.nix)]
    ++ [(import ./packages.nix)]
    ++ [(import ./scripts/scripts.nix)]
    ++ [(import ./swaylock.nix)]
    ++ [(import ./vscodium.nix)]
    ++ [(import ./waybar)]
    ++ [(import ./wofi.nix)]
    ++ [(import ./zsh.nix)]
    ++ [(import ./tmux.nix)];
}
