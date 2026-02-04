{ username, ... }:
{
  imports = [
    #./hardware-configuration.nix
    #./../../modules/core
    #./../../modules/core/virtualization.nix
    #./../../modules/services/tailscale.nix
    #./../../modules/services/mpd.nix
    #./../../modules/services/smart-monitoring.nix
    #./../../modules/services/mullvad.nix
    #./../../modules/home/steam.nix
    #./../../modules/services/ollama.nix
    #./../../modules/services/automount.nix
  ];

  environment.systemPackages = [
    pkgs.vim
  ];

  security.pam.enableSudoTouchIdAuth = true;
  system.primaryUser = username;

  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brewPrefix = "/opt/homebrew/bin";
    caskArgs = {
      no_quarantine = true;
    };
    casks = [
      "libreoffice"
      "signal"
      "handbrake"
      "tailscale"
      "ungoogled-chromium"
      # "orca-slicer"
      "element"
      "raycast"
      "anki"
    ];
  };
}
