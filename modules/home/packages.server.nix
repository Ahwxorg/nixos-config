{ pkgs, ... }:
{
  home.packages = [
    pkgs.vimv
    pkgs.jq
    pkgs.wireguard-tools
    pkgs.openresolv # required for wireguard-tools
    pkgs.tmux
    pkgs.htop
    pkgs.eza
    pkgs.file
    pkgs.fzf
    pkgs.lazygit
    pkgs.ripgrep
    pkgs.yt-dlp
    pkgs.fastfetch
    pkgs.python3
    pkgs.ffmpeg
    pkgs.killall
    pkgs.libnotify
    pkgs.man-pages
    pkgs.openssl
    pkgs.unzip
    pkgs.wget
    pkgs.xxd
    pkgs.borgbackup
    pkgs.nodejs
  ];
}
