{ pkgs, ... }:
let
  setbg = pkgs.writeScriptBin "setbg" (builtins.readFile ./scripts/setbg);
  walp = pkgs.writeScriptBin "walp" (builtins.readFile ./scripts/walp);
  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  notes = pkgs.writeShellScriptBin "notes" (builtins.readFile ./scripts/notes.sh);
  grabtext = pkgs.writeShellScriptBin "grabtext" (builtins.readFile ./scripts/grabtext.sh);
  unfuck = pkgs.writeShellScriptBin "unfuck" (builtins.readFile ./scripts/unfuck.sh);
  hidname = pkgs.writeShellScriptBin "hidname" (builtins.readFile ./scripts/hidname.sh);
  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (
    builtins.readFile ./scripts/toggle_oppacity.sh
  );
  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./scripts/ascii.sh);
  dock-on-all-monitors = pkgs.writeScriptBin "dock-on-all-monitors" (
    builtins.readFile ./scripts/dock-on-all-monitors.sh
  );
in
{
  home.packages = with pkgs; [
    setbg
    walp
    runbg
    notes
    grabtext
    unfuck
    hidname
    toggle_blur
    toggle_oppacity
    ascii
    dock-on-all-monitors
  ];
}
