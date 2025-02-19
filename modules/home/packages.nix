{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    element-desktop                                 # Nheko is kinda shit so sadly this has to happen
    iamb                                            # In-terminal-Matrix-messaging
    signal-desktop                                  # Since the bridge is broken :(
    tesseract                                       # Screen grabbing text from images/PDFs/etc
    pixcat                                          # Display images in the terminal
    lm_sensors                                      # Show sensor outputs, i.e. temperatures
    yubikey-touch-detector                          # Display notification when YubiKey requires a headpat
    pass                                            # Passwords but CLI
    # wikit                                           # Wikipedia summaries from the terminal, not added to Nix yet
    # reader                                          # Firefox reader mode but in the terminal, not added to Nix yet
    vimv                                            # edit filenames in batch with $EDITOR
    # pastel                                          # generate, analyze, convert and manipulate colors
    glow                                            # Render Markdown from the terminal
    # htmlq                                           # jq but for HTML
    eva                                             # Calculator
    anki-bin                                        # Flashcards
    obs-studio                                      # Record video stuff
    exiftool                                        # Read exif data from CLI
    translate-shell                                 # Google Translate but in the CLI
    wireguard-tools                                 # VPN connections
    openresolv                                      # required for wireguard-tools
    progress
    zip
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
    lazygit
    gitleaks
    libreoffice
    xfce.thunar
    lunar-client
    ripgrep
    yt-dlp
    spotify
    spotify-player
    thunderbird
    neofetch
    hyfetch
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
