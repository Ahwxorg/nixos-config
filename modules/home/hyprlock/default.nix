{ pkgs, username, ... }:
{
  imports = [ (import ./scripts.nix) ];

  home.packages = with pkgs; [
    hyprlock
  ];

  home.file = {
    "/home/${username}/.config/hypr/hyprlock.conf" = {
      executable = false;
      text = ''
        background {
            monitor =
            path = /home/liv/.local/share/bg.png
            blur_passes = 2
            contrast = 1
            brightness = 0.6
            vibrancy = 0.2
            vibrancy_darkness = 0.2
        }

        auth {
            fingerprint {
                enabled = true
                ready_message = Scan fingerprint to unlock
                present_message = Scanning...
                retry_delay = 250 # in milliseconds
            }
        }

        general {
            no_fade_in = false
            no_fade_out = false
            hide_cursor = false
            grace = 0
            disable_loading_bar = false
        }

        input-field {
            monitor =
            size = 250, 60
            outline_thickness = 2
            dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.35 # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true
            outer_color = rgba(0, 0, 0, 0)
            inner_color = rgba(0, 0, 0, 0.2)
            font_color = rgb(209, 207, 207)
            fade_on_empty = false
            rounding = 32
            fail_color = rgba(191, 97, 106, 0.75)
            check_color = rgba(235, 203, 139, 0.75)
            placeholder_text = <span foreground="##cdd6f4">Password</span>
            hide_input = false
            position = 0, -400
            halign = center
            valign = center
        }

        label {
          monitor =
          text = cmd[update:1000] echo "$(date +"%A, %B %d")"
          color = rgba(209, 207, 207, 0.75)
          font_size = 22
          font_family = JetBrains Mono
          position = 0, 300
          halign = center
          valign = center
        }

        label {
          monitor = 
          text = cmd[update:1000] echo "$(date +"%-H:%M")"
          color = rgba(209, 207, 207, 0.75)
          font_size = 95
          font_family = JetBrains Mono Extrabold
          position = 0, 200
          halign = center
          valign = center
        }

        # Profile Picture
        # image {
        #     monitor =
        #     path = /home/liv/.face
        #     size = 100
        #     border_size = 3
        #     rounding = 64
        #     border_color =  rgb(133, 180, 234) 
        #     position = 0, -100
        #     halign = center
        #     valign = center
        # }

        # CURRENT SONG
        image {
            monitor = 
            size = 256 # lesser side if not 1:1 ratio
            rounding = 6 # negative values mean circle
            border_size = 2
            border_color =  rgb(133, 180, 234)
            rotate = -6 # degrees, counter-clockwise
            reload_time = 2
            reload_cmd = ~/.local/bin/hyprlock-art.sh
            position = 0, -25
            halign = center
            valign = center
            opacity = 1
        }

        image {
            monitor = 
            size = 256 # lesser side if not 1:1 ratio
            rounding = 6 # negative values mean circle
            border_size = 3
            border_color =  rgb(133, 180, 234)
            rotate = 0 # degrees, counter-clockwise
            reload_time = 2
            reload_cmd = /home/liv/.local/bin/hyprlock-art.sh
            position = 0, -25
            halign = center
            valign = center
            opacity = 1
        }

        label {
            monitor =
            text = cmd[update:1000] echo "$(waybar-music | jq .text --raw-output)" 
            color = rgba(209, 207, 207, 0.75)
            #color = rgba(255, 255, 255, 0.6)
            font_size = 17  
            font_family = JetBrains Mono Nerd Font Mono ExtraBold
            position = 0, -200
            halign = center
            valign = center
        }

        label {
            monitor =
            text = cmd[update:6000000] echo "$(bash /home/liv/.local/bin/weather.sh)"
            color = rgba(255, 255, 255, 1)
            font_size = 10
            font_family = JetBrains Mono Nerd Font Mono ExtraBold
            position = 0, 50
            halign = center
            valign = top
        }

        label {
            monitor =
            text = cmd[update:1000] echo -e "$(/home/liv/.local/bin/hyprlock-battery.sh)"
            color = rgba(255, 255, 255, 1)
            font_size = 12
            font_family = JetBrains Mono Nerd Font Mono ExtraBold
            position = 0, 0
            halign = right
            valign = bottom
        }
      '';
    };
  };
}
