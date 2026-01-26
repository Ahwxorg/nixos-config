{ host, ... }:
{
  services.kanshi = {
    enable = true;

    profiles = {
      laptops = {
        outputs =
          if (host == "sakura") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else if (host == "zinnia") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else if (host == "april") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else if (host == "imilia") then
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ]
          else
            [
              {
                criteria = "eDP-1";
                scale = 1.0;
                status = "enable";
                position = "0,0";
              }
            ];
      };
      work = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "HP Inc. HP E27q G5 CNC4190NG9";
            scale = 1.0;
            status = "enable";
            position = "4816,0";
          }
          {
            criteria = "HP Inc. HP E27q G5 CNC4081M2B";
            scale = 1.0;
            status = "enable";
            position = "2256,0";
          }
        ];
      };
      home = {
        outputs = [
          {
            criteria = "LG Electronics LG ULTRAGEAR+ 507NTRLM0646";
            scale = 1.0;
            status = "enable";
            position = "0,0";
            # adaptiveSync = true;
            mode = if (host == "sakura") then "2560x1440@60Hz" else "2560x1440@60Hz";
          }
          {
            criteria = "eDP-1";
            status = if (host == "sakura") then "disable" else "disable";
            position = if (host == "sakura") then "152,1440" else "300,1440";
          }
        ];
      };
      home-alt = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "CMT GM34-CWQ CMI231700118";
            scale = 1.0;
            status = "enable";
            position = "0,0";
          }
          # {
          #   criteria = "";
          #   scale = 1.0;
          #   status = "enable";
          #   position = "0,0";
          # }
        ];
      };
    };
  };
}
