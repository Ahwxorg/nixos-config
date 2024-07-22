{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    wireguard-tools                   # VPN connections
    openresolv                        # required for wireguard-tools
    pwgen
    jq
    tmux
    wdisplays
    htop
    firefox
    lxappearance
    nsxiv
    eza
    file
    fzf
    gimp
    darktable
    lazygit
    libreoffice
    xfce.thunar
    prismlauncher
    modrinth-app
    lunar-client
    jdk
    ripgrep
    yt-dlp
    wineWowPackages.wayland
    element-desktop-wayland
    tut
    iamb
    spotify
    thunderbird
    neofetch
    yarn

    # C / C++
    gcc
    gnumake

    # Python
    python3

    ffmpeg
    killall
    libnotify
    man-pages			              # extra man pages
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
