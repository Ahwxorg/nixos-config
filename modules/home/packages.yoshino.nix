{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    pciutils                                        # List PCI(e) devices and controllers
    bandwhich                                       # Terminal bandwidth utilization tool
    element-desktop                                 # Nheko is kinda shit so sadly this has to happen
    signal-desktop                                  # Since the bridge is broken :(
    tesseract                                       # Screen grabbing text from images/PDFs/etc
    pixcat                                          # Display images in the terminal
    lm_sensors                                      # Show sensor outputs, i.e. temperatures
    yubikey-touch-detector                          # Display notification when YubiKey requires a headpat
    linuxKernel.packages.linux_hardened.v4l2loopback # Use A7ii as webcam
    # wikit                                           # Wikipedia summaries from the terminal, not added to Nix yet
    # reader                                          # Firefox reader mode but in the terminal, not added to Nix yet
    vimv                                            # edit filenames in batch with $EDITOR
    pastel                                          # generate, analyze, convert and manipulate colors
    glow                                            # Render Markdown from the terminal
    htmlq                                           # jq but for HTML
    android-tools                                   # ADB/Fastboot
    eva                                             # Calculator
    # termpdfpy                                       # Read PDFs from the terminal, errors out for now
    anki-bin                                        # Review flashcards
    vimv                                            # Bulk rename
    exiftool                                        # Read exif data from CLI
    translate-shell                                 # Google Translate but in the CLI
    wireguard-tools                                 # VPN connections
    openresolv                                      # required for wireguard-tools
    progress
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
    lazygit
    gitleaks                          # TODO: adds pre-commit hook
    xfce.thunar
    lunar-client
    jdk
    ripgrep
    yt-dlp
    wineWowPackages.wayland
    spotify
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
    man-pages			              # extra man pages
    mpv                               # video player
    openssl
    pamixer                           # pulseaudio command line mixer
    lxqt.pavucontrol-qt                    # pulseaudio volume controle (GUI)
    playerctl                         # controller for media players
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    cliphist                          # clipboard history manager
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
