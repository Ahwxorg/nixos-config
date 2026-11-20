{ pkgs, username, ... }:
{
  home.packages = [
    pkgs.nsxiv
  ];

  home.file."/home/${username}/.config/nsxiv/exec/key-handler" = {
    text = ''
      #!/bin/sh

      while read file
      do
        case "$1" in
          "w") setbg "$file" ;; 
          "d") mkdir -p "$HOME/.trash/" && mv "$file" "$HOME/.trash/";; 
        esac 
      done
    '';
  };
}
