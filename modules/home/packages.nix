{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    tmux
    wdisplays
    htop
    firefox
    nsxiv
    eza                               # ls replacement
    file                              # Show file information 
    fzf                               # fuzzy finder
    gtt                               # google translate TUI
    gimp
    lazygit
    libreoffice
    xfce.thunar                       # file manager
    nix-prefetch-github
    prismlauncher                     # minecraft launcher
    ripgrep                           # grep replacement
    yt-dlp
    wineWowPackages.wayland
    element-desktop-wayland
    spotify
    thunderbird
    neofetch
    yarn

    # C / C++
    gcc
    gnumake

    # Python
    python3

    gparted                           # partition manager
    ffmpeg
    imv                               # image viewer
    killall
    libnotify
    man-pages			      # extra man pages
    mpv                               # video player
    openssl
    pamixer                           # pulseaudio command line mixer
    pavucontrol                       # pulseaudio volume controle (GUI)
    playerctl                         # controller for media players
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    cliphist                          # clipboard history manager
    poweralertd
    unzip
    wget
    xdg-utils
    xxd
    inputs.alejandra.defaultPackage.${system}
  ];
}
