{
  lib,
  stdenv,
  fetchgit,
  unstableGitUpdater,
}:

stdenv.mkDerivation {
  name = "nixos-centered-plymouth";
  version = "2026-04-28";

  src = fetchgit {
    url = "https://code.liv.town/liv/nixos-centered-plymouth";
    rev = "d7c01ff3ca1da939ca9a8b7d72ed1a63ecc1638f";
    hash = "sha256-2bC3OrlYdAlYFF0pZYULt25IJVY0w04meaYnDksd7sI=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plymouth/themes/nixos-centered
    cp -r $src/{*.plymouth,images} $out/share/plymouth/themes/nixos-centered/
    substituteInPlace $out/share/plymouth/themes/nixos-centered/*.plymouth --replace '@IMAGES@' "$out/share/plymouth/themes/nixos-centered/images"

    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Centered and coloured NixOS Plymouth theme";
    homepage = "https://code.liv.town/liv/nixos-centered-plymouth";
    license = lib.licenses.mit;
    maintainers = [ ];
    platforms = lib.platforms.all;
  };
}
