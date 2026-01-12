{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Environment shit
    tesseract
    yubikey-touch-detector
    wireguard-tools
    openresolv
    xdg-utils
    killall
    libnotify
    openssl
    pamixer
    playerctl
    wl-clipboard
    cliphist
    poweralertd
    ffmpeg
    zip
    unzip
    wget
    xxd
    gcc
    gnumake
    python3
    nautilus
    qbittorrent

    # CLI shit
    imagemagick
    foot
    # termpdfpy # shit broke again smfh
    vimv
    pass
    lm_sensors
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
    htop
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
    # wikit
    # reader
    nmap
    # speedtest-go
    powertop
    android-tools
    sshpass
    net-tools
    nmap
    aerc

    # Install pip packages
    # python3
    # python3Packages.pip
    # (writeShellScriptBin "install-pip-packages" '' # This script does not run, yet.
    #   pip install --user --break-system-packages <package>
    # '')

    # Email/calendar/etc
    # neomutt
    w3m
    # khard
    # khal
    # vdirsyncer
  ];
}
