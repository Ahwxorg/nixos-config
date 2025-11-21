{ ... }:
{
  imports =
    [ (import ./dnscrypt.nix) ]
    # ++ [ (import ../opensnitch.nix) ]
    ++ [ (import ./syslogd.nix) ];
}
