{ pkgs, username, ... }:
{
  environment.systemPackages = [
    pkgs.libc
  ];

  programs.steam-asahi = {
    enable = true;
    # Optional: on 32 GiB machines this leaves the compositor about 8GB headroom.
    memoryMiB = 24576;
  };

  users.users.${username}.extraGroups = [
    "kvm"
    "fuse"
  ];
}
