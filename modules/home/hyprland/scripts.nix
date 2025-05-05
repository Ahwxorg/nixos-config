{ username, ... }:

{
  home.file = {
    "/home/${username}/.config/sxiv/exec/key-handler" = {
      executable = true;
      text = ''
        #!/bin/sh

        while read file
        do
          case "$1" in
            "w") setbg "$file" ;; 
            "d") mv "$file" "$HOME/.trash/";; 
          esac 
        done
      '';
    };
    "/home/${username}/.local/bin/setbg" = {
      executable = true;
      text = ''
        #!/bin/sh

        convert "$1" ~/.local/share/bg.png
        swww img ~/.local/share/bg.png --transition-type fade
      '';
    };
    "/home/${username}/.local/bin/walp" = {
      executable = true;
      text = ''
        #!/bin/sh

        which swiv &>/dev/null && SIV=swiv || SIV=nsxiv # todo: switch to swiv, but that is not packaged for Nix yet.
        $SIV -t ~/Pictures/wallpapers/other/*
      '';
    };
  };

}
