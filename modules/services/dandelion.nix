{ ... }:
{
  imports =
    [ (import ./docker.nix) ]
    # ++ [ (import ./immich.nix) ]
    # ++ [ (import ./nextcloud.nix) ]
    ++ [ (import ./home-assistant.nix) ]
    ++ [ (import ./monitoring.nix) ]
    ++ [ (import ./smart-monitoring.nix) ]
    ++ [ (import ./tailscale.nix) ]
    ++ [ (import ./nfs.nix) ]
    ++ [ (import ./hd-idle.nix) ];
}
