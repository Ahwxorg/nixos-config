{
  self,
  pkgs,
  lib,
  inputs,
  system,
  ...
}:
{
  imports =
    [ (import ./i18n.nix) ]
    ++     [ (import ./nixos.nix) ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 67108864; # Set buffer size to 64MB for large downloads
      allowed-users = [ "@wheel" ];
      # substituters = [ "http://violet.booping.local" ];
      # trusted-public-keys = [ "violet.booping.local:2gshN3xfGSL7eKFc8tGkqSoIb3WQxuB2RJ8DuakLLqc=%" ];
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    overlays = [
      self.overlays.default
      # inputs.nur.overlay
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # "jitsi-meet-1.0.8043"
      # "olm-3.2.16"
      # "libsoup-2.74.3"
    ];
    overlays = [
      self.overlays.default
      inputs.nur.overlay
      inputs.nixocaine.overlays.default
    ];
  };

  # Font packages
  environment.systemPackages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ipaexfont
  ];

  time.timeZone = lib.mkDefault "Europe/Amsterdam";
  environment.variables = {
    LC_TIME = "C.UTF-8";
  };
}
