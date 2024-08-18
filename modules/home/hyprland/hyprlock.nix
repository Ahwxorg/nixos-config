{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;

    extraConfig = ''
      source = $HOME/nixos-config/modules/home/hyprland/mocha.conf

      $accent = 0xb3$tealAlpha
      $accentAlpha = $tealAlpha
      $font = JetBrainsMono Nerd Font
      
      # GENERAL
      general {
          disable_loading_bar = true
          hide_cursor = true
      }
      
      # BACKGROUND
      background {
          monitor =
          path = ~/Pictures/wallpapers/others/street-by-ahwx.jpg
          blur_passes = 2
          color = $base
      }
      
      # TIME
      label {
          monitor =
          text = cmd[update:30000] echo "$(date +"%R")"
          color = $text
          font_size = 90
          font_family = $font
          position = -130, -100
          halign = right
          valign = top
          shadow_passes = 2
      }
      
      # DATE 
      label {
          monitor = 
          text = cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"
          color = $text
          font_size = 25
          font_family = $font
          position = -130, -250
          halign = right
          valign = top
          shadow_passes = 2
      }
      
      # KEYBOARD LAYOUT
      label {
          monitor =
          text = $LAYOUT
          color = $text
          font_size = 20
          font_family = $font
          rotate = 0 # degrees, counter-clockwise
      
          position = -130, -310
          halign = right
          valign = top
          shadow_passes = 2
      }
      
      # USER AVATAR
      image {
          monitor = 
          path = $HOME/.face
          size = 350
          border_color = $accent
          rounding = -1
      
          position = 0, 75
          halign = center
          valign = center
          shadow_passes = 2
      }
      
      # INPUT FIELD
      input-field {
          monitor =
          size = 400, 70
          outline_thickness = 4
          dots_size = 0.2
          dots_spacing = 0.2
          dots_center = true
          outer_color = $accent
          inner_color = $surface0
          font_color = $text
          fade_on_empty = false
          placeholder_text = <span foreground="##$textAlpha">󰌾 Logged in as $USER</span>
          hide_input = false
          check_color = $accent
          fail_color = $red
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
          capslock_color = $yellow
          position = 0, -185
          halign = center
          valign = center
          shadow_passes = 2
      }'';
  };
}
