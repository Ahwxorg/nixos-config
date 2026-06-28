{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main.capslock = "overload(control, esc)";
      control = {
        h = "left";
        j = "down";
        k = "up";
        l = "right";
      };
      meta = {
        k = "C-k";
        j = "C-j";
        l = "C-l";
      };
    };
  };
}
