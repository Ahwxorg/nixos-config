{ username, ... }:

{
  home.file = {
    "/home/${username}/.config/nsxiv/exec/key-handler" = {
      executable = true;
      text = ''
        #!/bin/sh

        while read file
        do
          case "$1" in
            "w") setbg "$file" ;; 
            "d") mv "$file" "$HOME/.trash/";; 
            "s") mkdir -p "$HOME/temp" && cp "$file" "$HOME/temp" ;;
            "r") mkdir -p "$HOME/temp" && cp "$(basename "$file" ".JPG").RAF" "$HOME/temp" ;;
            "e") echo -e "'$(pwd)"/"$(basename "$file" ".JPG").RAF'\n'$(pwd)/""$file""'" ;;
          esac 
        done
      '';
    };
    "/home/${username}/.local/bin/setbg" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        magick convert "$1" ~/.local/share/bg.png
        swww img ~/.local/share/bg.png --transition-type fade
      '';
    };
    "/home/${username}/.local/bin/walp" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        which swiv &>/dev/null && SIV=swiv || SIV=nsxiv # todo: switch to swiv, but that is not packaged for Nix yet.
        $SIV -t ~/Pictures/wallpapers/others/*
      '';
    };
  };

}
