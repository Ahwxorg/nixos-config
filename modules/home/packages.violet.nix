{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    jq
    tmux
    htop
    eza
    file
    fzf
    lazygit
    ripgrep
    yt-dlp
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
    man-pages			      # extra man pages
    openssl
    unzip
    wget
    xxd
    inputs.alejandra.defaultPackage.${system}
    inputs.nixvim.packages.${pkgs.system}.default
  ];
}
