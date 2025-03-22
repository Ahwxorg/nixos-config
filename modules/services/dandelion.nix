{ ... }: {
  imports =
       [(import ./docker.nix)]
    ++ [(import ./immich.nix)];
    # ++ [(import ./scrutiny.nix)];
}
