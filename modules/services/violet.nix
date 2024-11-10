{ ...}: {
  imports =
       [(import ./invidious.nix)]
    ++ [(import ./mumble.nix)]
    ++ [(import ./ntfy.nix)]
    ++ [(import ./sharkey-proxy.nix)]
    ++ [(import ./monitoring.nix)]
    ++ [(import ./docker.nix)]
    ++ [(import ./gokapi.nix)]
    ++ [(import ./nginx.nix)]
    ++ [(import ./komga.nix)]
    ++ [(import ./frp.nix)]
    # ++ [(import ./nextcloud.nix)]
    ++ [(import ./matrix/default.nix)];
    # ++ [(import ./tmux.nix)];
}
