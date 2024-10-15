{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    signal-desktop                                  # Since the bridge is broken :(
    socat                                           # Required for `hyprland-smart-borders`
    tesseract                                       # Screen grabbing text from images/PDFs/etc
    pixcat                                          # Display images in the terminal
    lm_sensors                                      # Show sensor outputs, i.e. temperatures
    yubikey-touch-detector                          # Display notification when YubiKey requires a headpat
    bitwarden-cli                                   # Use Bitwarden as a CLI secrets manager
    gajim                                           # XMPP client
    nheko                                           # Matrix client
    linuxKernel.packages.linux_hardened.v4l2loopback # Use A7ii as webcam
    # wikit                                           # Wikipedia summaries from the terminal, not added to Nix yet
    # reader                                          # Firefox reader mode but in the terminal, not added to Nix yet
    vimv                                            # edit filenames in batch with $EDITOR
    pastel                                          # generate, analyze, convert and manipulate colors
    glow                                            # Render Markdown from the terminal
    htmlq                                           # jq but for HTML
    lemmeknow                                       # Identify anything
    android-tools                                   # ADB/Fastboot
    eva                                             # Calculator
    tofi                                            # drun type launcher
    # termpdfpy                                       # Read PDFs from the terminal, errors out for now
    anki-bin                                        # Learn languages
    vimv                                            # Bulk rename
    audacity                                        # Record audio stuff
    obs-studio                                      # Record video stuff
    exiftool                                        # Read exif data from CLI
    pinta                                           # "Paint.NET-like editor"
    kdenlive                                        # Video editor
    translate-shell                                 # Google Translate but in the CLI
    wireguard-tools                                 # VPN connections
    openresolv                                      # required for wireguard-tools
    prusa-slicer
    blender
    progress
    epy
    zip
    ripdrag
    pwgen
    jq
    tmux
    wdisplays
    htop
    firefox
    nsxiv
    eza
    file
    fzf
    gimp
    darktable
    lazygit
    gitleaks                          # TODO: adds pre-commit hook
    libreoffice
    xfce.thunar
    prismlauncher
    lunar-client
    jdk
    ripgrep
    yt-dlp
    wineWowPackages.wayland
    # element-desktop # wayland version is very laggy for me
    spotify
    thunderbird
    neofetch
    nodejs_22
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
    lxqt.pavucontrol-qt                    # pulseaudio volume controle (GUI)
    playerctl                         # controller for media players
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    cliphist                          # clipboard history manager
    poweralertd
    unzip
    wget
    xdg-utils
    xxd
    inputs.alejandra.defaultPackage.${system}
    inputs.nixvim.packages.${pkgs.system}.default
  ];

  # environment.systemPackages = with pkgs; [
    # nodePackages.
  # ]
}
