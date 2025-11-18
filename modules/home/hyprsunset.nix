{
  services.hyprsunset.enable = true;

  home.file.".config/hypr/hyprsunset.conf".text = ''
    max-gamma = 200;
    profile {
      time = 06:00;
      identity = true;
    }
    profile {
      time = 21:00;
      temperature = 5500;
      gamma = 0.8;
    }
  '';
}
