{ pkgs, ... }:
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
  ];
}
