{ host, ... }:
{
  services.kanshi = {
    enable = true;

    settings = {
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
