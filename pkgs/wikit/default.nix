{ lib, ... }:
with lib;
let
  src = fetchFromGitHub {
    owner = "owner";
    repo = "repo";
    rev = "";
  };
in {
  wikit = mkYarnPackage {
    name = "wikit";
    inherit src;
    packageJSON = src + "./package.json";
    yarnLock = src + "./yarn.lock";
  };
}
