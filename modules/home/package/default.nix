{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    aichat                            # Chat with gpt-3.5/chatgpt in terminal.
    bitwise                           # cli tool for bit / hex manipulation
    # discord
    eza                               # ls replacement
    entr                              # perform action when file change
    file                              # Show file information 
    fzf                               # fuzzy finder
    lazygit
    libreoffice
    nitch                             # systhem fetch util
    nix-prefetch-github
    prismlauncher                     # minecraft launcher
    ripgrep                           # grep replacement
    rnix-lsp
    spotify
    todo                              # cli todo list
    toipe                             # typing test in the terminal
    cinnamon.nemo-with-extensions     # file manager
    yazi                              # terminal file manager
    youtube-dl

    # C / C++
    gcc
    gnumake

    bleachbit                         # cache cleaner
    gparted                           # partition manager
    ffmpeg
    imv                               # image viewer
    libnotify
    mpv                               # video player
    openssl
    pamixer                           # pulseaudio command line mixer
    pavucontrol                       # pulseaudio volume controle (GUI)
    playerctl                         # controller for media players
    qalculate-gtk                     # calculator
    unzip
    wget
    xdg-utils
    inputs.alejandra.defaultPackage.${system}
  ]);
}
