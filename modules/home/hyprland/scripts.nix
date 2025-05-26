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
  };
}
