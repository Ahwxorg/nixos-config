{ pkgs, ... }:
{
  home.packages = [
    # Environment shit
    pkgs.ffmpeg
    pkgs.zip
    pkgs.unzip
    pkgs.wget
    pkgs.xxd
    pkgs.gcc
    pkgs.gnumake
    pkgs.python3
    pkgs.qbittorrent
    pkgs.mpv
    pkgs.qutebrowser
    pkgs.xfce4-taskmanager

    # CLI shit
    pkgs.imagemagick
    pkgs.vimv
    pkgs.pass
    pkgs.fastfetch
    pkgs.hyfetch
    pkgs.glow
    pkgs.eva
    pkgs.exiftool
    pkgs.translate-shell
    pkgs.progress
    pkgs.pwgen
    pkgs.jq
    pkgs.tmux
    pkgs.eza
    pkgs.file
    pkgs.fzf
    pkgs.lazygit
    pkgs.gitleaks
    pkgs.ripgrep
    pkgs.yt-dlp
    pkgs.nodejs_22
    pkgs.yarn
    pkgs.cargo
    pkgs.rustc
    pkgs.nmap
    pkgs.speedtest-go
    pkgs.android-tools
    pkgs.sshpass
    pkgs.net-tools
    pkgs.nmap
    pkgs.aerc
    pkgs.w3m
    pkgs.spotify-player
    pkgs.ansible

    # aspell
    # aspellDicts.de
    # aspellDicts.nl
    # aspellDicts.uk

    # Hunspell dictionaries for spell checking
    # hunspell
    # hunspellDicts.de_DE # German
    # hunspellDicts.en_GB-ise # UK English with -ise spellings
    # hunspellDicts.en_US
    # hunspellDicts.nl_NL # Dutch
    # hunspellDicts.nl_nl # Dutch (alternative)

    # Install pip packages
    # python3
    # python3Packages.pip
    # (writeShellScriptBin "install-pip-packages" '' # This script does not run, yet.
    #   pip install --user --break-system-packages <package>
    # '')
  ];
}
