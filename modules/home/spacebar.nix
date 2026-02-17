{ pkgs, username, ... }:
{
  home.packages = with pkgs; [
    spacebar
  ];

  home.file."/users/${username}/.config/spacebar/spacebarrc" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh

      spacebar -m config position top
      spacebar -m config height 34
      spacebar -m config title on
      spacebar -m config spaces on
      spacebar -m config clock on
      spacebar -m config power on
      spacebar -m config padding_left 20
      spacebar -m config padding_right 20
      spacebar -m config spacing_left 25
      spacebar -m config spacing_right 15
      spacebar -m config text_font "scientifica:Regular:12.0"
      spacebar -m config icon_font "scientifica:Regular:12.0"
      spacebar -m config background_color 0xff202020
      spacebar -m config foreground_color 0xffa8a8a8
      spacebar -m config space_icon_color 0xffaaaaaa
      spacebar -m config power_icon_color 0xffaaaaaa
      spacebar -m config battery_icon_color 0xffaaaaaa
      spacebar -m config dnd_icon_color 0xffaaaaaa
      spacebar -m config clock_icon_color 0xffaaaaaa
      spacebar -m config power_icon_strip "BATT: " "CHAR: " #  
      spacebar -m config space_icon_strip 1 2 3 4 5 6 7 8 9 10
      spacebar -m config clock_icon "CLCK: "
      spacebar -m config dnd_icon "DND"
      spacebar -m config clock_format "%d/%m/%y %R"

      echo "spacebar configuration loaded.."
    '';
  };
}
