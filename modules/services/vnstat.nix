{
  lib,
  config,
  pkgs,
  ...
}:

let
  vnstatUser = "vnstatd";
  vnstatImageDir = "/var/www/vnstat";
  vnstatDashboardFile = pkgs.writeText "dashboard.html" ''
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <title>vnStat dashboard</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <noscript>
          <meta http-equiv="refresh" content="60" />
        </noscript>
        <style>
        body { max-width: 1341px; margin: auto; padding: 5px; }
        div { column-count: 2; column-width: 668px; column-gap: 5px; text-align: center }
        img { max-width: 100%; min-width: 320px; }
        </style>
      </head>
      <body>
        <div>
          <img src="vnstat-s.png"> <img src="vnstat-5g.png"> <img src="vnstat-hg.png">
          <img src="vnstat-h.png"> <img src="vnstat-d.png"> <img src="vnstat-t.png">
          <img src="vnstat-m.png"> <img src="vnstat-y.png">
        </div>
        <script>
          setInterval(function() {
              for (let image of document.images) {
                image.src = new URL(image.src).pathname + "?t=" + new Date().getTime();
              }
          }, 60000);
        </script>
      </body>
    </html>'';

  serverName = "vnstat.abnv.me";
  serviceConfig = config.services."${serverName}";
  options = {
    enable = lib.mkEnableOption "${serverName} service";
  };
in
{
  options.services.${serverName} = options;
  config = lib.mkIf serviceConfig.enable {
    services.vnstat.enable = true;

    systemd = {
      tmpfiles.rules = [
        "d ${vnstatImageDir} 1775 ${vnstatUser} ${vnstatUser}"
        "L+ ${vnstatImageDir}/index.html - - - - ${vnstatDashboardFile}"
        "Z ${vnstatImageDir} 755 ${vnstatUser} ${vnstatUser}"
      ];

      services."vnstati-web" = {
        enable = true;
        description = "service that generates images for vnstat monitoring";
        startAt = "*:0/5:00";
        restartIfChanged = true;
        after = [ "vnstat.service" ];
        path = [ pkgs.vnstat ];
        serviceConfig = {
          User = vnstatUser;
          Group = vnstatUser;
          WorkingDirectory = vnstatImageDir;
          Type = "oneshot";
          AmbientCapabilities = [ ];
          CapabilityBoundingSet = [ ];
          KeyringMode = "private";
          LockPersonality = true;
          NoNewPrivileges = true;
          PrivateDevices = true;
          PrivateMounts = true;
          PrivateTmp = true;
          ProtectClock = true;
          ProtectControlGroups = true;
          ProtectHome = true;
          ProtectHostname = true;
          ProtectKernelLogs = true;
          ProtectKernelModules = true;
          ProtectKernelTunables = true;
          ProtectSystem = "full";
          RemoveIPC = true;
          RestrictAddressFamilies = [ ];
          RestrictNamespaces = true;
          RestrictRealtime = true;
        };
        script = ''
          vnstati --style 1 -L -s -o vnstat-s.png
          vnstati --style 1 -L --fivegraph 576 218 -o vnstat-5g.png
          vnstati --style 1 -L -hg -o vnstat-hg.png
          vnstati --style 1 -L -h 24 -o vnstat-h.png
          vnstati --style 1 -L -d 30 -o vnstat-d.png
          vnstati --style 1 -L -t 10 -o vnstat-t.png
          vnstati --style 1 -L -m 12 -o vnstat-m.png
          vnstati --style 1 -L -y 5 -o vnstat-y.png
        '';
      };

      timers."vnstat-image-gen".timerConfig = {
        User = vnstatUser;
        Group = vnstatUser;
      };
    };

    services.nginx.virtualHosts.${serverName} = {
      root = vnstatImageDir;
      extraConfig = ''
        add_header Cache-Control 'private no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0';
        if_modified_since off;
        expires off;
        etag off;
      '';
    };
  };
}
