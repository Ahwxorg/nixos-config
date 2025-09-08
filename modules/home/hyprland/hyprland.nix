{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    grim
    slurp
    wl-clip-persist
    glib
    wayland
    direnv
    inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
  ];
  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprbars
      # pkgs.hyprlandPlugins.hyprspace # causes hyprland to crash on 4-finger swipe; great software
    ];
  };
}
