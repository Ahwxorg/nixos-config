{ ... }:
{
  programs.zathura = {
    enable = true;

    options = {
      guioptions = "v";
      adjust-open = "width";
      statusbar-basename = true;
      render-loading = false;
      scroll-step = 920;
    };
  };
}
