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
    pixcat
    lm_sensors
    neofetch
    hyfetch
    glow
    eva
    exiftool
    translate-shell
    progress
    zip
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
    # wikit
    # reader

    # GUI shit
    element-desktop
    signal-desktop
    anki-bin
    obs-studio
    wdisplays
    librewolf # main
    ungoogled-chromium # for things that don't work with librewolf
    qutebrowser # focus
    nsxiv
    libreoffice
    xfce.thunar
    spotify
    thunderbird
    lxqt.pavucontrol-qt
    mpv

    # Gaming
    lunar-client

    inputs.alejandra.defaultPackage.${system}
    inputs.nixvim.packages.${pkgs.system}.default

    # Email/calendar/etc
    neomutt
    khard
    khal
    w3m
  ];
}
