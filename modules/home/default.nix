{ pkgs, inputs, config, username, host, ...}:
  imports =
    if (host == "sakura") then 
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
    ++ [(import ./tmux.nix)]
    else if (host == "violet") then
       [(import ./git.nix)]
    ++ [(import ./nvim.nix)]
    ++ [(import ./packages.violet.nix)]
    ++ [(import ./scripts/scripts.nix)]
    ++ [(import ./zsh.nix)]
    ++ [(import ./tmux.nix)]
    else if (host == "yoshino") then
       [(import ./git.nix)]
    ++ [(import ./swaync/default.nix)]
    ++ [(import ./fonts.nix)]
    ++ [(import ./hyprland)]
    ++ [(import ./kitty.nix)]
    ++ [(import ./mako.nix)]
    ++ [(import ./nvim.nix)]
    ++ [(import ./zathura.nix)]
    ++ [(import ./packages.yoshino.nix)]
    ++ [(import ./scripts/scripts.nix)]
    ++ [(import ./swaylock.nix)]
    ++ [(import ./waybar)]
    ++ [(import ./wofi.nix)]
    ++ [(import ./zsh.nix)]
    ++ [(import ./tmux.nix)];
}
