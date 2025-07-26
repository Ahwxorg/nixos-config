{
  pkgs,
  lib,
  ...
}:
{
  # TODO: add https://github.com/FraioVeio/plymouth-xp-theme
  boot.loader.timeout = 1;
  boot.plymouth = {
    enable = lib.mkDefault true;
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "lone" ];
        # selected_themes = [ "sliced" ];
        # selected_themes = [ "rings" ];
        # selected_themes = [ "red_loader" ];
        # selected_themes = [ "dna" ];
        # selected_themes = [ "hexagon_dots" ];
      })
    ];
  };
}
