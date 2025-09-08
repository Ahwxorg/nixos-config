{
  self,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # substituters = [ "http://violet.booping.local" ];
      # trusted-public-keys = [ "violet.booping.local:2gshN3xfGSL7eKFc8tGkqSoIb3WQxuB2RJ8DuakLLqc=%" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
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
      "jitsi-meet-1.0.8043"
      "olm-3.2.16"
      "libsoup-2.74.3"
    ];
    overlays = [
      self.overlays.default
      inputs.nur.overlay
    ];
  };

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  # Font packages
  environment.systemPackages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ipaexfont
  ];

  time.timeZone = lib.mkDefault "Europe/Amsterdam";
  system.stateVersion = "24.05";
}
