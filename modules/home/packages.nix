{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Environment shit
    ffmpeg
    zip
    unzip
    wget
    xxd
    gcc
    gnumake
    python3
    qbittorrent

    # CLI shit
    imagemagick
    vimv
    pass
    neofetch
    hyfetch
    glow
    eva
    exiftool
    translate-shell
    progress
    pwgen
    jq
    tmux
    eza
    file
    fzf
    lazygit
    gitleaks
    ripgrep
    yt-dlp
    nodejs_22
    yarn
    cargo
    rustc
    nmap
    speedtest-go
    android-tools
    sshpass
    net-tools
    nmap
    aerc
    w3m

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
