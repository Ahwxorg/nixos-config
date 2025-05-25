{ pkgs, ... }:
let
  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  notes = pkgs.writeShellScriptBin "notes" (builtins.readFile ./scripts/notes.sh);
  grabtext = pkgs.writeShellScriptBin "grabtext" (builtins.readFile ./scripts/grabtext.sh);
  unfuck = pkgs.writeShellScriptBin "unfuck" (builtins.readFile ./scripts/unfuck.sh);
  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (
    builtins.readFile ./scripts/toggle_oppacity.sh
  );
  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./scripts/ascii.sh);
in
{
  home.packages = with pkgs; [
    runbg
    notes
    grabtext
    unfuck
    toggle_blur
    toggle_oppacity
    ascii
  ];
}
