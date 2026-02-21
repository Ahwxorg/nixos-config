{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sketchybar
    sketchybar-app-font
    lua
    readline
    switchaudio-osx
    nowplaying-cli
    # sf-symbols
    # font-sf-mono
    # font-sf-pro
  ];
  home.file = {
    ".config/sketchybar/sketchybarrc" = {
      executable = true;
      text = builtins.readFile ./sketchybarrc;
    };
    # PLUGINS
    ".config/sketchybar/plugins/battery.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/battery.sh;
    };
    ".config/sketchybar/plugins/clock.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/clock.sh;
    };
    ".config/sketchybar/plugins/front_app.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/front_app.sh;
    };
    ".config/sketchybar/plugins/memory.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/memory.sh;
    };
    ".config/sketchybar/plugins/nowplaying.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/nowplaying.sh;
    };
    ".config/sketchybar/plugins/space.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/space.sh;
    };
    ".config/sketchybar/plugins/volume.sh" = {
      executable = true;
      text = builtins.readFile ./plugins/volume.sh;
    };
  };
}
