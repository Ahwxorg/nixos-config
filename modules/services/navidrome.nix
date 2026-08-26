{
  config,
  lib,
  pkgs,
  ...
}:
let
  lyrics-navidrome = pkgs.stdenv.mkDerivation {
    pname = "nd-lyrics";
    version = "6.1.3";

    src = pkgs.fetchurl {
      url = "https://github.com/J0R6IT0/navidrome-lyrics-plugin/releases/download/v6.1.3/nd-lyrics.ndp";
      hash = "sha256-U54KfULuMBDkJYzn4nuV8oKdaqJU20MMhnDv43rB9dY=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share
      cp $src $out/share/nd-lyrics.ndp
    '';

    passthru = {
      isNavidromePlugin = true;
    };
  };

  musixmatch-navidrome = pkgs.stdenv.mkDerivation {
    pname = "navidrome-musixmatch-plugin";
    version = "0.2.1";

    src = pkgs.fetchurl {
      url = "https://github.com/Myzel394/navidrome-musixmatch-plugin/releases/download/v0.2.1/navidrome-musixmatch-plugin.ndp";
      hash = "sha256-g6tlWbvfKMSNLqnnc33Mk93/tpYd3Hrfccd2i6bJ988=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share
      cp $src $out/share/navidrome-musixmatch-plugin.ndp
    '';

    passthru = {
      isNavidromePlugin = true;
    };
  };
in
{
  services.navidrome = {
    enable = true;
    package = pkgs.navidrome;
    group = "music";
    environmentFile = config.sops.secrets.navidromeEnvironment.path;
    plugins = [
      pkgs.navidromePlugins.listenbrainz-daily-playlist
      pkgs.navidromePlugins.apple-music
      lyrics-navidrome
      musixmatch-navidrome
    ];
    settings = {
      Address = "127.0.0.1";
      Agents = "listenbrainz,lastfm,deezer";
      EnableInsightsCollector = false;
      BaseUrl = "https://listen.liv.town";
      MusicFolder = "/spinners/ahwx/Music";
      DataFolder = "/var/lib/navidrome";
      LogFile = "/var/lib/navidrome/navidrome.log";
      EnableSharing = true;
      LyricsPriority = ".lrc,nd-lyrics,navidrome-musixmatch-plugin,.txt,embedded";
      Plugins = {
        Enabled = true;
        AutoReload = true;
      };
      ExtAuth.TrustedSources = "10.13.37.0/24";
      # ExtAuth.LogoutUrl = "https://authenticate.liv.town/logout";
      AuthenticationMethod = "external";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    RootDirectory = lib.mkForce "";

    BindReadOnlyPaths = lib.mkForce [ "" ];

    ReadWritePaths = [
      "/spinners/ahwx/Music"
    ];
  };

  users.groups.music = { };
  users.users.navidrome.group = "music";

  services.nginx.virtualHosts = {
    "listen.liv.town" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/liv.town/cert.pem";
      sslCertificateKey = "/var/lib/acme/liv.town/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:4533/";
        proxyWebsockets = true;
        extraConfig = ''
          auth_request /tinyauth;
          auth_request_set $redirection_url $upstream_http_x_tinyauth_location;
          error_page 401 403 =302 $redirection_url;
          auth_request_set $tinyauth_remote_user $upstream_http_remote_user;
          proxy_set_header remote-user $tinyauth_remote_user;
        '';
      };
      locations."/tinyauth" = {
        extraConfig = ''
          internal;
          proxy_pass http://localhost:3030/api/auth/nginx;
          proxy_pass_request_body off;
          proxy_set_header Content-Length "";
          proxy_set_header x-forwarded-for $remote_addr;
          proxy_set_header x-real-ip $remote_addr;
          proxy_set_header x-forwarded-proto $scheme;
          proxy_set_header x-forwarded-host $http_host;
          proxy_set_header x-forwarded-uri $request_uri;
        '';
      };
    };
  };
}
