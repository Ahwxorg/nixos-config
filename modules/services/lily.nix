{ ... }:
{
  imports =
    [ (import ./docker.nix) ]
    ++ [ (import ./monitoring.nix) ]
    ++ [ (import ./smart-monitoring.nix) ]
    ++ [ (import ./unifi.nix) ]
    ++ [ (import ./tailscale.nix) ]
    ++ [ (import ./grafana.nix) ];
}
