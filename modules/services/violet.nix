{ ... }:
{
  imports =
    [ (import ./invidious.nix) ]
    ++ [ (import ./mumble.nix) ]
    ++ [ (import ./ntfy.nix) ]
    ++ [ (import ./sharkey-proxy.nix) ]
    ++ [ (import ./librey-proxy.nix) ]
    ++ [ (import ./binternet-proxy.nix) ]
    ++ [ (import ./monitoring.nix) ]
    ++ [ (import ./docker.nix) ]
    ++ [ (import ./gokapi.nix) ]
    ++ [ (import ./nginx.nix) ]
    # ++ [(import ./komga.nix)]
    ++ [ (import ./frp.nix) ]
    ++ [ (import ./radicale.nix) ]
    ++ [ (import ./jellyfin.nix) ]
    ++ [ (import ./readarr.nix) ]
    ++ [ (import ./lidarr.nix) ]
    # ++ [(import ./smart-monitoring.nix)]
    # ++ [(import ./jitsi-meet.nix)]
    ++ [ (import ./forgejo.nix) ]
    ++ [ (import ./matrix/default.nix) ];
}
