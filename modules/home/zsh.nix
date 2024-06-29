{ hostname, config, pkgs, host, ...}: 
{
  programs = {
    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      localVariables = {
        # Looks like this: '~/some/path > '
        PS1 = "%F{magenta}%~%f > ";
        # Gets pushed to the home directory otherwise
        LESSHISTFILE = "/dev/null";
        # Make Vi mode transitions faster (in hundredths of a second)
        # KEYTIMEOUT = 1;
        LANG = "en_US.UTF-8";
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#808080";
      };

      shellAliases = {
        ls = "eza -lh --git";
        la = "eza -A --git";
        ll = "eza -l --git";
        lla = "eza -lA";
        # :q = "exit";
        ezit = "exit";
        irc = "ssh irc";
        wlc = "wl-copy";
        zshrc = "nvim ~/.zshrc";
        yt-dlp-audio = "yt-dlp -f 'ba' -x --audio-format mp3";
        zshconf = "nvim ~/.zshrc";
        open = "xdg-open";
        tree = "eza --icons --tree --group-directories-first";
        nvim = "nix run /home/liv/Development/nixvim --";
        doas = "sudo";

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
          name = "zsh-abbr";
          src = fetchFromGitHub {
            owner = "olets";
            repo = "zsh-abbr";
            rev = "752e9fcc4daff680545c30f8f857913d66f6f5e6";
            sha256 = "sha256-HY/F43fpWn1PBYb2c+qp0CyF3hpSFHUZdZLZRS1d9Yc=";
          };
          file = "zsh-abbr.sh";
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
