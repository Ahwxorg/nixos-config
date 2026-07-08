{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    awww
    grimblast
    hyprpicker
    grim
    slurp
    wl-clip-persist
    glib
    wayland
    direnv
    hypridle
    hyprtoolkit
  ];
  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # enableNvidiaPatches = false;
    systemd.enable = true;
    plugins = [
      # pkgs.hyprlandPlugins.hyprspace # causes hyprland to crash on 4-finger swipe; great software
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];
  };
}
