{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  genAgentRange =
    agent: from: to: sep: trailer:
    map (n: "${agent}${sep}${toString n}${trailer}") (lib.range from to);
in
{
  imports = [ inputs.nixocaine.nixosModules.default ];
  services.iocaine = {
    enable = true;
    config = {
      server.default = {
        bind = "127.0.0.1:42069";
        mode = "http";
        use.handler-from = "default";
      };
      handler.default = {
        config = {
          "ai-robots-txt-path" = inputs.ai-robots-txt;
          #unwanted-asns = {
          #  db-path = inputs.geolite2-asn-mmdb;
          #  list = map toString [
          #    7552 # VIETEL-AS-AP
          #    37963 # ALIBABA-CN-NET
          #    45102 # ALIBABA-CN-NET
          #    45899 # VNPT-AS-VN
          #    51167 # CONTABO
          #    62610 # ZEN-DPS
          #    132203 # TENCENT-NET-AP-CN
          #  ];
          #};
          #unwanted-visitors =
          #  # broad version ranges
          #  (genAgentRange "Android" 2 12 " " ".")
          #  ++ (genAgentRange "Chrome" 1 139 "/" ".")
          #  ++ (genAgentRange "Chrome" 141 148 "/" ".")
          #  ++ (genAgentRange "CriOS" 1 142 "/" ".")
          #  ++ (genAgentRange "Firefox" 1 139 "/" ".")
          #  ++ (genAgentRange "Firefox" 141 150 "/" ".")
          #  ++ (genAgentRange "FxiOS" 1 150 "/" ".")
          #  ++ (genAgentRange "iPhone OS" 1 14 " " "_")
          #  ++ (genAgentRange "Windows NT" 4 7 " " "")
          #  ++ (genAgentRange "Mac OS X 10." 5 14 "" "")
          #  ++ (genAgentRange "Mac OS X 10_" 5 14 "" "")
          #  ++ (genAgentRange "Mac OS X" 11 14 " " "")
          #  ++ [
          #    # manually crafted patterns
          #    "iPod;"
          #    "Presto/"
          #    "Trident/"
          #    "Windows CE"
          #    # Missing contact information
          #    "efx-scanner/3.0"
          #    "Go-http-client/1.1"
          #  ];
        };
      };
    };
  };
}
