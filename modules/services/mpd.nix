{
  username,
  config,
  pkgs,
  ...
}:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/dandelion/home/liv/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
      	name "pipewire"
      }
    '';
    user = "${username}"; # PipeWire requires this as it runs as the normal user and mpd normally runs as a system user.

    # Optional:
    # network.listenAddress = "any"; # if you want to allow non-localhost connections
    network.startWhenNeeded = false; # systemd feature: only start MPD service upon connection to its socket
  };
  systemd.services.mpd.environment = {
    # see: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.userRunningPipeWire.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };

  home.packages = with pkgs; [
    mpdris2
  ];
}
