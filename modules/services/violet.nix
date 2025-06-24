{ ... }:
{
  imports =
    [ (import ./invidious.nix) ]
    ++ [ (import ./anubis.nix) ]
    ++ [ (import ./binternet-proxy.nix) ]
    ++ [ (import ./docker.nix) ]
    ++ [ (import ./frp.nix) ]
    ++ [ (import ./forgejo.nix) ]
    ++ [ (import ./grafana.nix) ]
    ++ [ (import ./gokapi.nix) ]
    ++ [ (import ./jellyfin.nix) ]
    ++ [ (import ./librey-proxy.nix) ]
    ++ [ (import ./lidarr.nix) ]
    ++ [ (import ./matrix/default.nix) ]
    ++ [ (import ./mumble.nix) ]
    ++ [ (import ./monitoring.nix) ]
    ++ [ (import ./ntfy.nix) ]
    ++ [ (import ./sharkey-proxy.nix) ]
    ++ [ (import ./nginx.nix) ]
    # ++ [(import ./komga.nix)]
    ++ [ (import ./radicale.nix) ]
    ++ [ (import ./tailscale.nix) ]
    ++ [ (import ./guacamole.nix) ]
    ++ [ (import ./readarr.nix) ];
  # ++ [(import ./smart-monitoring.nix)]
  # ++ [(import ./jitsi-meet.nix)]
}
