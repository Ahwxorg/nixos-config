{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    vimv
    jq
    wireguard-tools
    openresolv # required for wireguard-tools
    tmux
    htop
    eza
    file
    fzf
    lazygit
    ripgrep
    yt-dlp
    neofetch

    # Python
    python3

    ffmpeg
    killall
    libnotify
    man-pages
    openssl
    unzip
    wget
    xxd
    borgbackup
    inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
