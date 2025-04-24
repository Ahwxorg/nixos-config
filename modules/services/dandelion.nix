{ ... }:
{
  imports =
    [ (import ./docker.nix) ]
    ++ [ (import ./immich.nix) ]
    ++ [ (import ./nextcloud.nix) ]
    ++ [ (import ./home-assistant.nix) ]
    ++ [ (import ./smart-monitoring.nix) ];
}
