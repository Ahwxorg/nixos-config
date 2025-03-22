{ ... }:
{
  imports =
       [(import ./../../variables.nix)]
    ++ [(import ./hardware.nix)]
    ++ [(import ./network.nix)]
    ++ [(import ./program.nix)]
    ++ [(import ./sshd.nix)]
    ++ [(import ./security.nix)]
    ++ [(import ./services.nix)]
    ++ [(import ./system.nix)]
    ++ [(import ./user.nix)];
}
