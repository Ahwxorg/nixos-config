{ ... }:
{
  imports =
    [ (import ./docker.nix) ]
    ++ [ (import ./agenix.nix) ]
    ++ [ (import ./hardware.nix) ]
    # ++ [(import ./displaylink.nix)]
    # ++ [(import ./printing.nix)]
    ++ [ (import ./xserver.nix) ]
    ++ [ (import ./network.nix) ]
    ++ [ (import ./pipewire.nix) ]
    ++ [ (import ./program.nix) ]
    ++ [ (import ./plymouth.nix) ]
    ++ [ (import ./sshd.nix) ]
    ++ [ (import ./security.nix) ]
    ++ [ (import ./services.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./user.nix) ]
    ++ [ (import ./bluetooth.nix) ]
    ++ [ (import ./yubikey.nix) ]
    ++ [ (import ./wayland.nix) ];
}
