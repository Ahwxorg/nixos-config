{ ... }:
{
  programs.kitty = {
    enable = true;

    # theme = "3024 Night";

    font = {
      name = "GohuFont 14 Nerd Font Mono";
      size = 9;
    };

    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.50";
      window_padding_width = 10;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;

      ## Tabs
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_foreground = "#1e1e2e";
      active_tab_background = "#cba6f7";
      inactive_tab_foreground = "#bac2de";
      inactive_tab_background = "#313244";
    };

    keybindings = {
      ## Unbind
      "ctrl+shift+left" = "no_op";
      "ctrl+shift+right" = "no_op";
    };
    extraConfig = ''
      # vim:ft=kitty

      ## name: Base2Tone Suburb Dark
      ## author: Bram de Haan (https://github.com/atelierbram)
      ## license: MIT
      ## upstream: https://github.com/atelierbram/Base2Tone-kitty/blob/main/themes/base2tone-suburb-dark.conf
      ## blurb: duotone theme | warm blue - bright pink


      #: The basic colors

      foreground #878ba6
      # background #1e202f
      selection_foreground #878ba6
      selection_background #292c3d


      #: Cursor colors

      cursor #d14781
      cursor_text_color #1e202f


      #: URL underline color when hovering with mouse

      url_color #d2d8fe


      #: kitty window border colors and terminal bell colors

      active_border_color #444864
      inactive_border_color #1e202f
      bell_border_color #5165e6
      visual_bell_color none


      #: OS Window titlebar colors

      wayland_titlebar_color #292c3d
      macos_titlebar_color #292c3d


      #: Tab bar colors

      active_tab_foreground #fbf9fa
      active_tab_background #1e202f
      inactive_tab_foreground #b0a6aa
      inactive_tab_background #292c3d
      tab_bar_background #292c3d
      tab_bar_margin_color none


      #: Colors for marks (marked text in the terminal)

      mark1_foreground #1e202f
      mark1_background #6375ee
      mark2_foreground #1e202f
      mark2_background #8d8186
      mark3_foreground #1e202f
      mark3_background #e44e8c


      #: The basic 16 colors

      #: black
      color0 #1e202f
      color8 #4f5472

      #: red
      color1 #7586f5
      color9 #fe81b5

      #: green
      color2 #fb6fa9
      color10 #292c3d

      #: yellow
      color3 #ffb3d2
      color11 #444864

      #: blue
      color4 #8696fd
      color12 #5b6080

      #: magenta
      color5 #fb6fa9
      color13 #d2d8fe

      #: cyan
      color6 #a0acfe
      color14 #f764a1

      #: white
      color7 #878ba6
      color15 #ebedff
    '';
  };
}
