{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      shift + alt - 1: yabai -m window --space 1
      shift + alt - 2: yabai -m window --space 2
      shift + alt - 3: yabai -m window --space 3
      shift + alt - 4: yabai -m window --space 4
      shift + alt - 5: yabai -m window --space 5
      shift + alt - 6: yabai -m window --space 6
      shift + alt - 7: yabai -m window --space 7
      shift + alt - 8: yabai -m window --space 8
      shift + alt - 9: yabai -m window --space 9
      shift + alt - 0: yabai -m window --space 10

      # focus window
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # move window
      shift + alt - h : yabai -m window --warp west
      shift + alt - j : yabai -m window --warp south
      shift + alt - k : yabai -m window --warp north
      shift + alt - l : yabai -m window --warp east

      alt + shirt - r; \
          skhd --reload; \
          yabai --restart-service

      # Float / Unfloat window
      alt - space : \
      yabai -m window --toggle float; \
      yabai -m window --toggle border

      # cmd - d : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "stack" else "bsp" end')
      alt - return: open -a Kitty -n
      alt + shift - t : open -na Mail
      alt + shift - c : open -na Chromium # open new instance
      alt + shift - e : open -a Element # move to existing instance

      alt - f : yabai -m window --toggle zoom-fullscreen

      alt + shift -f : yabai -m window --toggle native-fullscreen


      # # Linux-style word navigation and deletion
      # ctrl - backspace [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | alt - backspace  # Other apps: delete word
      # ]

      # ctrl - left [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | alt - left       # Other apps: move word left
      # ]

      # ctrl - right [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | alt - right      # Other apps: move word right
      # ]

      # # Home/End key behavior (with shift for selection)
      # home [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | cmd - left       # Other apps: line start
      # ]

      # shift - home [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | cmd + shift - left  # Other apps: select to line start
      # ]

      # # Ctrl+Home/End for document navigation
      # ctrl - home [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | cmd - up         # Other apps: document start
      # ]

      # ctrl - end [
      #     @native_apps ~         # Terminal apps handle natively
      #     *            | cmd - down       # Other apps: document end
      # ]
    '';
  };
}
