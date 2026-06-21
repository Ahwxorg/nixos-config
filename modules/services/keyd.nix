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
    };
  };
}
