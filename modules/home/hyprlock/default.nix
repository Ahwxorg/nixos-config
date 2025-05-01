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
        # GENERAL
        general {
          no_fade_in = true
          grace = 1
          disable_loading_bar = false
          hide_cursor = true
          ignore_empty_input = true
          text_trim = true
        }

        auth {
            fingerprint {
                enabled = true
                ready_message = Scan fingerprint to unlock
                present_message = Scanning...
                retry_delay = 250 # in milliseconds
            }
        }

        #BACKGROUND
        background {
            monitor = 
            path = screenshot
            blur_passes = 2
            contrast = 0.8916
            brightness = 0.7172
            vibrancy = 0.1696
            vibrancy_darkness = 0
        }

        # TIME HR
        label {
            monitor =
            text = cmd[update:1000] echo -e "$(date +"%H")"
            color = rgba(255, 255, 255, 1)
            shadow_pass = 2
            shadow_size = 3
            shadow_color = rgb(0,0,0)
            shadow_boost = 1.2
            font_size = 150
        #    font_family = JetBrains Mono Nerd Font Mono ExtraBold
            font_family = AlfaSlabOne 
            position = 0, -250
            halign = center
            valign = top
        }

        # TIME
        label {
            monitor =
            text = cmd[update:1000] echo -e "$(date +"%M")"
        #    color = 0xff$color0
            color = rgba(255, 255, 255, 1)
            font_size = 150
        #    font_family = JetBrains Mono Nerd Font Mono ExtraBold
            font_family = AlfaSlabOne
            position = 0, -420
            halign = center
            valign = top
        }

        # DATE
        label {
            monitor =
            text = cmd[update:1000] echo -e "$(date +"%d %b %A")"
            color = rgba(255, 255, 255, 1)
            font_size = 14
            font_family = JetBrains Mono Nerd Font Mono ExtraBold
            position = 0, -130
            halign = center
            valign = center
        }

        # WEATHER 
        label {
            monitor =
            text = cmd[update:6000000] echo "$(bash /home/${username}/.local/bin/weather.sh)"
            color = rgba(255, 255, 255, 1)
            font_size = 10
            font_family = JetBrains Mono Nerd Font Mono ExtraBold
            position = 0, 465
            halign = center
            valign = center
        }

        # INPUT FIELD
        input-field {
            monitor =
            size = 250, 60
            outline_thickness = 0
            outer_color = rgba(0, 0, 0, 1)
            dots_size = 0.1 # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 1 # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true
            inner_color = rgba(0, 0, 0, 1)
            font_color = rgba(200, 200, 200, 1)
            fade_on_empty = false
            font_family = JetBrains Mono Nerd Font Mono
            placeholder_text = <span foreground="##cdd6f4"> </span>
            hide_input = false
            position = 0, -470
            halign = center
            valign = center
            zindex = 10
        }
        # Information
        label {
            monitor =
            text = cmd[update:1000] echo -e "$(/home/${username}/.local/bin/hyprlock-battery.sh)"
            color = rgba(255, 255, 255, 1)
            font_size = 12
            font_family = JetBrains Mono Nerd Font Mono ExtraBold
            position = -20, -510
            halign = right
            valign = center
        }
      '';
    };
  };
}
