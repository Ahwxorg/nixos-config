{ inputs, pkgs, ... }:
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

    # CLI shit
    termpdfpy
    vimv
    iamb
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
    spotify-player
    nodejs_22
    yarn
    cargo
    rustc
    wikit
    reader
    nmap
    speedtest-go
    delta
    powertop
    android-tools
    sshpass

    # GUI shit
    element-desktop
    gajim
    signal-desktop
    anki-bin
    obs-studio
    wdisplays
    librewolf # main
    ungoogled-chromium # for things that don't work with librewolf
    nsxiv
    imv
    libreoffice
    xfce.thunar
    spotify
    thunderbird
    lxqt.pavucontrol-qt
    mpv
    plasma5Packages.kdeconnect-kde
    # onthespot-overlay

    # Gaming
    lunar-client

    inputs.alejandra.defaultPackage.${system}
    inputs.nixvim.packages.${pkgs.system}.default
    mermaid-cli
    gnuplot

    # Email/calendar/etc
    neomutt
    w3m
    khard
    khal
    vdirsyncer
  ];
}
