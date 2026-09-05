{ host, ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        output.criteria = "eDP-1";
        output.scale =
          if (host == "fragile") then
            1.25
          else if (host == "sakura") then
            1.25
          else
            1.0;
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      }
      {
        profile.name = "work";
        profile.outputs = [
          {
            criteria = "eDP-1";
          }
          {
            criteria = "HP Inc. HP E27q G5 CNC4190NG9";
            position = "3024,0";
          }
          {
            criteria = "HP Inc. HP E27q G5 CNC4081M2B";
            position = "5584,0";
          }
        ];
      }
      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "2560,0";
          }
          {
            criteria = "LG Electronics LG ULTRAGEAR+ 507NTRLM0646";
            position = "0,0";
            mode = if (host == "fragile") then "2560x1440@240Hz" else "2560x1440@60Hz";
          }
        ];
      }
    ];
  };
}
