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
    rev = "ccca3ee5e156a5e7e8d4c01734f844a21d284b05";
    hash = "sha256-mp3vTZ4YbG0GrJ+STp/av4mROtN3CpZHtAW0JiOKJfo=";
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
