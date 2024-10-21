{ lib, ... }:
with lib;
let
  src = fetchFromGitHub {
    owner = "KorySchneider";
    repo = "wikit";
    rev = "6432c6020606868cc5f240d0317040e38b992292";
  };
in {
  wikit = mkYarnPackage {
    name = "wikit";
    inherit src;
    packageJSON = src + "./package.json";
    yarnLock = src + "./yarn.lock";
  };
}
