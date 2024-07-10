{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    general = {
      disable_loading_bar = true;
      hide_cursor = true;
    };

    background = [{
      path = /home/liv/nixos-config/modules/home/hyprland/lockscreen.png;
      blur_passes = 0;
      color = "rgb(1e1e2e)"; # base
    }];

    input-field = [{
      size = "300, 60";
      outline_thickness = 4;
      dots_size = 0.2;
      dots_spacing = 0.5;
      dots_center = true;
      outer_color = "rgb(cba6f7)"; # mauve
      inner_color = "rgba(24, 24, 36, 1)";
   #  inner_color = $surface0;
      font_color = "rgba(203, 164, 243, 1)";
   #  font_color = $text;
      fade_on_empty = false;
      placeholder_text = "\<span foreground\=\'\#\#cba6f7\'\>\󰌾  Logged in as \<span foreground\=\'\#\#cba6f7\'\>\<b\>\$USER\<\/b\>\<\/span\>\<\/span\>";
   #  placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>;
      hide_input = false;
      check_color = "rgb(cba6f7)"; # mauve
      fail_color = "rgb(f38ba8)";
      fail_text = "\<i\>\<b\>\(\$ATTEMPTS\)\<\/b\>\<\/i\>";
      capslock_color = "rgb(f9e2af)";
      position = "0\, \-48";
      halign = "center";
      valign = "center";
    }];
  };


}
