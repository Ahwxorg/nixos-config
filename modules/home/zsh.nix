{
  hostname,
  config,
  pkgs,
  host,
  ...
}:
{
  programs = {
    command-not-found.enable = true;
    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      # enableGlobalCompInit = true; # Should be a thing according to NixOS options but is not a thing?

      localVariables = {
        # Looks like this: '~/some/path > '
        PS1 = "> %F{magenta}%~%f < ";
        RPROMPT = "%F{magenta}%m";
        # Gets pushed to the home directory otherwise
        LESSHISTFILE = "/dev/null";
        # Make Vi mode transitions faster (in hundredths of a second)
        # KEYTIMEOUT = 1;
        LANG = "en_US.UTF-8";
        EDITOR = "nvim";
        SYSTEMD_LESS = "FRXMK"; # Fix weird sideways scrolling in systemctl status ...
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#808080";
        ZSH_AUTOSUGGEST_USE_ASYNC = 1;
        HISTSIZE = 10000000;
        SAVEHIST = 10000000;
        HISTFILE = "~/.zsh_history";
        HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = 1;
      };

      initContent = ''
        autoload -U add-zsh-hook
        autoload -U compinit
        zmodload zsh/complist
        autoload -U edit-command-line
        zmodload zsh/zpty
        # Corrections
        setopt correct

        # Enable Ctrl-X Ctrl-E
        autoload edit-command-line
        zle -N edit-command-line
        bindkey '^Xe' edit-command-line

        # History stuff
        setopt append_history
        setopt inc_append_history
        setopt share_history
        setopt extended_history
        setopt hist_reduce_blanks
        setopt hist_ignore_space

        # Disable annoying beep
        setopt no_beep
        # Fix comments
        setopt interactive_comments

        bindkey '^[[H' beginning-of-line # Home
        bindkey '^[[F' end-of-line # End
        bindkey "^[[1;5C" forward-word # Ctrl+Right
        bindkey "^[[1;5D" backward-word # Ctrl+Left
        # Menu selection
        bindkey -M menuselect '^@' accept-and-infer-next-history # Ctrl+Space
        # Make Alt-Backspace delete till ~!#$%^&*(){}[]<>?+; the way OMZ does
        backward-delete-word-but-better () {
          local WORDCHARS='~!#$%^&*(){}[]<>?+;'
          zle backward-delete-word
        }
        zle -N backward-delete-word-but-better

        bindkey '\e^?' backward-delete-word-but-better

        # Completions
        #
        # Cache so it's a bit quicker
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        # File list like ls -l
        zstyle ':completion:*' file-list all
        # Glorious menu
        zstyle ':completion:*' menu select
        # Always tab complete
        zstyle ':completion:*' insert-tab false
        # Comments
        zstyle ':completion:*' verbose yes
        # Tab key behaviour
        zstyle ':autocomplete:tab:*' widget-style menu-complete
        # Make set // to be / instead of default /*/
        zstyle ':completion:*' squeeze-slashes true
        # Complete options
        zstyle ':completion:*' complete-options true
        # Complete partial words (such as 3912 > _DSC3912.JPG)
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        # Move around completion menu with Vi keys
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -M menuselect 'l' vi-forward-char


        function jitsi-link() {
          url=$(printf "https://meet.jit.si/%s" "$(uuidgen)")
          printf "%s" "''${url}" | wl-copy
          printf "%s\n" "''${url}"
        }

        function nixcd () {                             sakura
          PACKAGE_NAME="$1"
          if [[ "$PACKAGE_NAME" = "" ]]; then
            echo "Usage: nixcd <package name>"
          fi
          PKGINSTORE="$(NIXPKGS_ALLOW_UNFREE=1 nix path-info nixpkgs#$PACKAGE_NAME --impure)"
          if [[ -d "$PKGINSTORE" ]]; then
            cd $PKGINSTORE
          else
            echo "Could not find path for package: $PKGINSTORE"
            return 1
          fi
        }

        export export PATH="''${PATH}:''${HOME}/.local/bin/:''${HOME}/.cargo/bin/:''${HOME}/.fzf/bin/"

        # if [[ $(which sxiv&>/dev/null && echo 1) == "1" ]]; then
        #   alias imv="sxiv"
        # elif [[ $(which nsxiv&>/dev/null && echo 1) == "1" ]]; then
        #   alias imv="nsxiv"
        #   alias sxiv="nsxiv"
        # fi
      '';

      zsh-abbr = {
        enable = true;
        abbreviations = {
          mkdir = "mkdir -p";
          vim = "nvim";
          v = "nvim";
          vi = "nvim";
          nv = "nvim";
          nvi = "nvim";
          gc = "git clone";
          ga = "git add .";
          gcm = "git commit -m";
          gph = "git push -u origin main";
          g = "git";

          calc = "eva";
          wikipedia = "wikit";
        };
      };

      # setOptions = [
      #   # Corrections
      #   "CORRECT"
      #
      #   # History stuff
      #   "APPEND_HISTORY"
      #   "INC_APPEND_HOSTORY"
      #   "SHARE_HISTORY"
      #   "EXTENDED_HISTORY"
      #   "HIST_REDUCT_BLANKS"
      #   "HIST_IGNORE_SPACE"
      #
      #   # Disable annoying beep
      #   "NO_BEEP"
      #   # Fix comments
      #   "INTERACTIVE_COMMENTS"
      # ];

      shellAliases = {
        spt = "spotify_player";
        convert = "magick";
        ls = "eza -lh --git";
        la = "eza -A --git";
        ll = "eza -l --git";
        lla = "eza -lA";
        ":q" = "exit";
        ezit = "exit";
        wlc = "wl-copy";
        yt-dlp-audio = "yt-dlp -f 'ba' -x --audio-format mp3";
        open = "xdg-open";
        tree = "eza --icons --tree --group-directories-first";
        # nvim = "nix run /home/liv/Development/nixvim --";
        vim = "nvim";
        doas = "sudo";
        sxiv = "nsxiv";
        enby = "man";
        woman = "man";

        # NixOS
        ns = "nix-shell --run zsh";
        nix-shell = "nix-shell --run zsh";
        nix-switch = "sudo nixos-rebuild switch --flake ~/nixos-config#${host}";
        nix-switch-upgrade = "sudo nixos-rebuild switch --upgrade --flake ~/nixos-config#${host}";
        nix-flake-update = "sudo nix flake update ~/nixos-config#";
        nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
      };

      plugins = with pkgs; [
        {
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.6.0";
            sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
          };
          file = "zsh-syntax-highlighting.zsh";
        }
        {
          name = "zsh-autopair";
          src = fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
            sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
          };
          file = "autopair.zsh";
        }
      ];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
