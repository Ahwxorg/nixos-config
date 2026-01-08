{
  username,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    mpc
    mpdris2
    ncmpcpp
    rmpc
  ];

  services.mpd = {
    enable = true;
    settings = {
      playlist_directory = "/home/${username}/Music/.playlists";
      music_directory = "/home/${username}/Music";
      restore_paused = "yes";
      auto_update = "yes";

      audio_output = [
        {
          type = "pipewire";
          name = "pipewire";
        }
      ];
    };
    user = "${username}"; # PipeWire requires this as it runs as the normal user and mpd normally runs as a system user.

    # Optional:
    # network.listenAddress = "any"; # if you want to allow non-localhost connections
  };
  systemd.services.mpd.environment = {
    # see: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };
}
