{
  lib,
  pkgs,
  rustPlatform,
  fetchFromGitHub,
  writableTmpDirAsHomeHook,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "waybar-module-pomodoro";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "Andeskjerf";
    repo = "waybar-module-pomodoro";
    hash = "sha256-vB5WROn/GmaJyLNHnyfhTZItjQlJ+LMXMw8gOT1GM0s=";
    rev = "3867b25ab691c4a697ee2ffca76d7cc9408675cc";
  };

  cargoHash = "sha256-FTzqNkGn1dk+pdee8U07NI/uqUR6/gs51ZWOpYro3j8=";

  nativeCheckInputs = [
    writableTmpDirAsHomeHook
  ];

  meta = {
    description = "waybar module that provides a pomodoro timer";
    homepage = "https://github.com/Andeskjerf/waybar-module-pomodoro";
    maintainers = [ ];
  };
}
