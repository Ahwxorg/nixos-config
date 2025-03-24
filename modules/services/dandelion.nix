{ ... }: {
  imports =
       [(import ./docker.nix)]
    ++ [(import ./immich.nix)]
    ++ [(import ./nextcloud.nix)]
    ++ [(import ./scrutiny.nix)];
}
