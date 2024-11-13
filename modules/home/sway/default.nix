{ pkgs, ... }: {
  home.packages = with pkgs; [
    swayfx
    autotiling
  ];
}
