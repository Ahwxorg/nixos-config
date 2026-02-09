{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      # external_bar = "all:0:0";
      layout = "bsp";
      auto_balance = "on";
      window_placement = "second_child";
      window_opacity = "off";
      window_border = "on";
      window_border_placement = "inset";
      window_border_width = 2;
      window_border_radius = 3;
      window_shadow = "float";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";

      mouse_modifier = "cmd";
      # set modifier + right-click drag to resize window (default: resize)
      mouse_action2 = "resize";
      # set modifier + left-click drag to resize window (default: move)
      mouse_action1 = "move";

      mouse_follows_focus = "off";
      focus_follows_mouse = "autofocus";

      # gaps
      top_padding = 0;
      bottom_padding = 0;
      left_padding = 0;
      right_padding = 0;
      window_gap = 0;
    };

    extraConfig = ''
      # osascript -e 'tell application id "tracesOf.Uebersicht" to refresh'
      # rules
      yabai -m rule --add app=".*" sub-layer=normal
      yabai -m rule --add app="^System Settings$"    manage=off
      yabai -m rule --add app="^System Information$" manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add title="Preferences$"       manage=off
      yabai -m rule --add title="Settings$"          manage=off
      yabai -m rule --add app="Finder$"              manage=off

      # workspace management
      yabai -m space 1 --label web
      yabai -m space 2 --label terminal
      yabai -m space 6 --label config
      yabai -m space 7 --label notes
      yabai -m space 8 --label chat
      yabai -m space 9 --label music
      yabai -m space 10 --label mail

      yabai -m rule --add app="Element" space=chat
      yabai -m rule --add app="Signal" space=chat
      yabai -m rule --add app="Spotify" space=music

      yabai -m rule --add app="Calendar" space=mail
      yabai -m rule --add app="Mail" space=mail

      yabai -m rule --add app='About This Mac' manage=off
      yabai -m rule --add app='System Information' manage=off
      yabai -m rule --add app='System Preferences' manage=off

      yabai -m signal --add event=dock_did_restart \
      action="sudo yabai --load-sa"
      sudo yabai --load-sa

      # yabai -m config external_bar all:40:0
      # exec ~/.config/borders/bordersrc &
    '';
  };

}
