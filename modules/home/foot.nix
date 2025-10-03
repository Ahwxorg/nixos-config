{ pkgs, username, ... }:
{
  home.file."/home/${username}.config/foot/foot.ini".text = ''
    # -*- conf -*-

    # font=GohuFont 14 Nerd Font Mono:size=9
    initial-window-mode=maximized
    # [tweak]
    # allow-overflowing-double-width-glyphs=true

    [desktop-notifications]
    # command=notify-send --wait --app-name $\{app-id} --icon $\{app-id} --category $\{category} --urgency $\{urgency} --expire-time $\{expire-time} --hint STRING:image-path:$\{icon} --hint BOOLEAN:suppress-sound:$\{muted} --hint STRING:sound-name:$\{sound-name} --replace-id $\{replace-id} $\{action-argument} --print-id -- $\{title} $\{body}
    # command-action-argument=--action $\{action-name}=$\{action-label}
    # close=""
    # inhibit-when-focused=yes

    [cursor]
    style=block

    [colors]
    alpha=0.5

    background=000000
    foreground=878ba6
    flash=7f7f00
    flash-alpha=0.5

    ## Normal/regular colors (color palette 0-7)
    regular0=1e202f  # black
    regular1=7586f5  # red
    regular2=fb6fa9  # green
    regular3=ffb3d2  # yellow
    regular4=8696fd  # blue
    regular5=fb6fa9  # magenta
    regular6=a0acfe  # cyan
    regular7=878ba6  # white

    ## Bright colors (color palette 8-15)
    bright0=4f5472   # bright black
    bright1=fe81b5   # bright red
    bright2=292c3d   # bright green
    bright3=444864   # bright yellow
    bright4=5b6080   # bright blue
    bright5=d2d8fe   # bright magenta
    bright6=f764a1   # bright cyan
    bright7=ebedff   # bright white
  '';
}
